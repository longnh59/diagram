from collections import OrderedDict
from dataclasses import dataclass
import re
import sys

import openpyxl


WORKBOOK = "Book1.xlsx"
OUTPUT_SQL = "generated_book1_schema.sql"
DATABASE = "book1"
SECTION2_START_ROW = 1034
SUPPORTED_TYPES = {
    "array",
    "boolean",
    "date",
    "double",
    "float",
    "int",
    "object",
    "timestamp",
    "varchar",
}
NATURAL_KEY_REFERENCES = {
    "macosodaotao": "cosogiaoducdaihoc",
}


@dataclass
class Column:
    source_name: str
    name: str
    col_type: str
    nullable: bool
    key: str
    description: str


def quote_ident(value):
    return "`" + str(value).replace("`", "``") + "`"


def clean_ident(value):
    text = str(value).strip()
    text = re.sub(r"\s+", "_", text)
    return text[:64]


def sql_literal(value):
    text = "" if value is None else str(value)
    text = text.replace("\\", "\\\\").replace("'", "''")
    return "'" + text[:1024] + "'"


def mysql_type(data_type, length):
    dtype = "" if data_type is None else str(data_type).strip().lower()
    try:
        n = int(length) if length is not None else None
    except (TypeError, ValueError):
        n = None

    if dtype == "varchar":
        return f"VARCHAR({min(max(n or 255, 1), 16383)})"
    if dtype == "int":
        return "INT"
    if dtype == "boolean":
        return "BOOLEAN"
    if dtype == "date":
        return "DATE"
    if dtype == "timestamp":
        return "DATETIME"
    if dtype == "double":
        return "DOUBLE"
    if dtype == "float":
        return "FLOAT"
    if dtype in {"object", "array"}:
        return "JSON"
    return "VARCHAR(255)"


def is_not_null(value):
    if value is None:
        return False
    text = str(value).strip().lower()
    return text in {"x", "1", "1..n"}


def uniquify_columns(columns):
    seen = {}
    result = []
    for column in columns:
        base = clean_ident(column.source_name)
        count = seen.get(base, 0) + 1
        seen[base] = count
        final_name = base if count == 1 else clean_ident(f"{base}_{count}")
        result.append(
            Column(
                source_name=column.source_name,
                name=final_name,
                col_type=column.col_type,
                nullable=column.nullable,
                key=column.key,
                description=column.description,
            )
        )
    return result


def index_name(prefix, column_name):
    return clean_ident(f"{prefix}_{column_name}")[:64]


def create_table_sql(table_name, columns, pk_lookup):
    unique_columns = uniquify_columns(columns)
    primary_keys = [column.name for column in unique_columns if column.key == "PK"]
    foreign_keys = [column for column in unique_columns if column.key == "FK"]
    lines = []
    constraints = []

    for column in unique_columns:
        nullable = False if column.key == "PK" else column.nullable
        line = f"  {quote_ident(column.name)} {column.col_type}{' NOT NULL' if not nullable else ''}"
        if column.description:
            line += f" COMMENT {sql_literal(column.description)}"
        lines.append(line)

    if primary_keys:
        constraints.append(
            f"  PRIMARY KEY ({', '.join(quote_ident(column) for column in primary_keys)})"
        )

    for natural_key, target_table in NATURAL_KEY_REFERENCES.items():
        if table_name == target_table and any(column.name == natural_key for column in unique_columns):
            constraints.append(f"  UNIQUE KEY {quote_ident(index_name('uq', natural_key))} ({quote_ident(natural_key)})")

    for column in foreign_keys:
        target_tables = pk_lookup.get(clean_ident(column.source_name).lower(), [])
        target_tables = [target_table for target_table in target_tables if target_table != table_name]
        if len(target_tables) == 1:
            target_table = target_tables[0]
            constraints.append(f"  KEY {quote_ident(index_name('idx', column.name))} ({quote_ident(column.name)})")
            constraints.append(
                "  CONSTRAINT "
                f"{quote_ident(index_name('fk', f'{table_name}_{column.name}'))} "
                f"FOREIGN KEY ({quote_ident(column.name)}) "
                f"REFERENCES {quote_ident(target_table)} ({quote_ident(clean_ident(column.source_name))})"
            )
        else:
            constraints.append(f"  KEY {quote_ident(index_name('idx', column.name))} ({quote_ident(column.name)})")

    all_lines = lines + constraints
    return (
        f"DROP TABLE IF EXISTS {quote_ident(table_name)};\n"
        f"CREATE TABLE {quote_ident(table_name)} (\n"
        + ",\n".join(all_lines)
        + "\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n"
    )


def prefer_lowercase_tables(tables):
    grouped = {}
    for table_name in tables:
        grouped.setdefault(table_name.lower(), []).append(table_name)

    filtered = OrderedDict()
    dropped = []
    for _normalized_name, table_names in grouped.items():
        if len(table_names) == 1:
            filtered[table_names[0]] = tables[table_names[0]]
            continue

        lowercase_names = [name for name in table_names if name == name.lower()]
        preferred_name = lowercase_names[0] if lowercase_names else table_names[0]
        filtered[preferred_name] = tables[preferred_name]
        dropped.extend(name for name in table_names if name != preferred_name)

    return filtered, dropped


def load_tables(workbook=None):
    ws = openpyxl.load_workbook(workbook or WORKBOOK, data_only=True).active

    tables = OrderedDict()
    current_table = None
    for row in ws.iter_rows(min_row=2, values_only=True):
        if not any(value is not None for value in row):
            continue

        row = list(row) + [None] * 7
        table_name, column_name, data_type, length, not_null, key, description = row[:7]
        dtype = "" if data_type is None else str(data_type).strip().lower()

        if dtype in SUPPORTED_TYPES:
            if table_name:
                current_table = clean_ident(table_name)
                tables[current_table] = []
            if current_table and column_name:
                key_text = "" if key is None else str(key).strip().upper()
                tables[current_table].append(
                    Column(
                        source_name=str(column_name).strip(),
                        name=clean_ident(column_name),
                        col_type=mysql_type(data_type, length),
                        nullable=not is_not_null(not_null),
                        key=key_text,
                        description="" if description is None else str(description).strip(),
                    )
                )
            continue

        if len(row) >= 5:
            _id, service, schema_name, table_name, column_name = row[:5]
            if not schema_name or not table_name or not column_name:
                continue
            full_table_name = clean_ident(f"{schema_name}__{table_name}")
            tables.setdefault(full_table_name, [])
            tables[full_table_name].append(
                Column(
                    source_name=str(column_name).strip(),
                    name=clean_ident(column_name),
                    col_type="VARCHAR(255)",
                    nullable=True,
                    key="",
                    description="",
                )
            )
    return prefer_lowercase_tables(tables)


def pk_lookup(tables):
    lookup = {}
    for table_name, columns in tables.items():
        for column in uniquify_columns(columns):
            if column.key == "PK":
                lookup.setdefault(column.name.lower(), []).append(table_name)

    for natural_key, target_table in NATURAL_KEY_REFERENCES.items():
        if target_table in tables:
            target_columns = {column.name for column in uniquify_columns(tables[target_table])}
            if natural_key in target_columns:
                lookup[natural_key] = [target_table]
    return lookup


def main():
    workbook = sys.argv[1] if len(sys.argv) > 1 else None
    tables, dropped_tables = load_tables(workbook)
    lookup = pk_lookup(tables)
    with open(OUTPUT_SQL, "w", encoding="utf-8", newline="\n") as sql:
        sql.write(f"CREATE DATABASE IF NOT EXISTS {quote_ident(DATABASE)} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\n")
        sql.write(f"USE {quote_ident(DATABASE)};\n\n")
        sql.write("SET FOREIGN_KEY_CHECKS=0;\n\n")
        for table_name in dropped_tables:
            sql.write(f"DROP TABLE IF EXISTS {quote_ident(table_name)};\n")
        if dropped_tables:
            sql.write("\n")
        for table_name, columns in tables.items():
            sql.write(create_table_sql(table_name, columns, lookup))
            sql.write("\n")
        sql.write("SET FOREIGN_KEY_CHECKS=1;\n")

    print(
        f"Wrote {OUTPUT_SQL} for database {DATABASE}: "
        f"{len(tables)} tables, dropped {len(dropped_tables)} duplicate mixed-case tables"
    )


if __name__ == "__main__":
    main()
