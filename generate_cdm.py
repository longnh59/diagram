from collections import OrderedDict, defaultdict
from dataclasses import asdict
from pathlib import Path
import html
import json
import os
import re
import sys


def _load_dotenv():
    """Doc file .env trong thu muc project (KEY=VALUE moi dong).
    Khong ghi de bien moi truong da co san. Khong can thu vien ngoai."""
    env_path = Path(__file__).parent / ".env"
    if not env_path.exists():
        return
    for raw in env_path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, val = line.partition("=")
        key, val = key.strip(), val.strip().strip('"').strip("'")
        if key and key not in os.environ:
            os.environ[key] = val


_load_dotenv()

from generate_book1_schema import (
    NATURAL_KEY_REFERENCES,
    clean_ident,
    load_tables,
    pk_lookup,
    uniquify_columns,
)


OUTPUT_DIR = Path("cdm_output")

TECHNICAL_COLUMNS = {
    "idbanghi",
    "sukien",
    "phienban",
    "thoigiancapnhat",
    "ngaycapnhat",
}

DOMAIN_RULES = [
    ("Institution & Organization", ["cosogiaoduc", "cocautochuc", "toanha", "datdai", "phonghoc"]),
    ("Learner Profile", ["ttchunghocvien"]),
    ("Learning & Study", ["thongtinhoctap", "chuongtrinhdaotao", "danhsachnganhdaotao"]),
    ("Credential & Certificate", ["vanbang", "chungchi"]),
    ("Reward & Discipline", ["khenthuong", "kyluat"]),
    ("Staff & Lecturer", ["canbogiangvien", "phongbandonvicongtac", "quatrinhcongtac", "quatrinhdaotao"]),
]

ENTITY_LABELS = {
    "cosogiaoducdaihoc": "Higher Education Institution",
    "thongtincocautochuc": "Organization Unit",
    "thongtintoanha": "Building",
    "csvcvatrangthietbidatdai": "Land / Facility Asset",
    "phonghocgiangduongvahoitruong": "Teaching Room / Hall",
    "ttchunghocvien": "Learner",
    "thongtinhoctapsvdh": "Postgraduate Study Record",
    "ThongTinHocTapSVDH": "Postgraduate Study Record",
    "VanBangChungChi": "Credential / Certificate",
    "KhenThuong": "Reward",
    "KyLuat": "Discipline",
    "ThongTinCanBoGiangVien": "Staff / Lecturer",
    "PhongBanDonViCongTac": "Work Unit Assignment",
    "QuaTrinhCongTacCuaCanBoGiangVien": "Teaching / Work History",
    "QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien": "Staff Education / Training History",
    "DanhSachNganhDaoTao": "Training Major",
    "ChuongTrinhDaoTao": "Training Program",
}

TABLE_CLASS_RULES = OrderedDict(
    [
        (
            "core_entity",
            {
                "cosogiaoducdaihoc",
                "ttchunghocvien",
                "ThongTinCanBoGiangVien",
                "DanhSachNganhDaoTao",
                "ChuongTrinhDaoTao",
                "VanBangChungChi",
            },
        ),
        (
            "transaction_or_event",
            {
                "thongtinhoctapsvdh",
                "ThongTinHocTapSVDH_QuyetDinhThoiHocBaoLuu",
                "KhenThuong",
                "KyLuat",
                "QuaTrinhCongTacCuaCanBoGiangVien",
                "QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien",
                "VanBangChungChi_ThongTinHieuChinh",
            },
        ),
        (
            "asset_facility",
            {
                "thongtintoanha",
                "csvcvatrangthietbidatdai",
                "phonghocgiangduongvahoitruong",
            },
        ),
        (
            "organization_structure",
            {
                "thongtincocautochuc",
                "PhongBanDonViCongTac",
            },
        ),
    ]
)

REFERENCE_COLUMN_PREFIXES = (
    "ma",
    "loai",
    "hinhthuc",
    "trangthai",
    "tinhtrang",
)

INFERRED_CONCEPTUAL_RELATIONSHIPS = [
    {
        "from_table": "ttchunghocvien",
        "from_column": "macosodaotao",
        "to_table": "cosogiaoducdaihoc",
        "to_column": "macosodaotao",
        "type": "inferred-business-key",
        "conceptual": True,
        "note": "Học viên thuộc cơ sở đào tạo — macosodaotao là business key liên kết.",
    },
    {
        "from_table": "ThongTinCanBoGiangVien",
        "from_column": "macosodaotao",
        "to_table": "cosogiaoducdaihoc",
        "to_column": "macosodaotao",
        "type": "inferred-business-key",
        "conceptual": True,
        "note": "Cán bộ-giảng viên thuộc cơ sở đào tạo — macosodaotao là business key liên kết.",
    },
    {
        "from_table": "thongtinhoctapsvdh",
        "from_column": "mahocvien",
        "to_table": "ttchunghocvien",
        "to_column": "mahocvien",
        "type": "inferred-business-key",
        "conceptual": True,
        "note": "Hồ sơ học tập gắn với học viên qua mahocvien.",
    },
    {
        "from_table": "VanBangChungChi",
        "from_column": "mahocvien",
        "to_table": "ttchunghocvien",
        "to_column": "mahocvien",
        "type": "inferred-business-key",
        "conceptual": True,
        "note": "Văn bằng/chứng chỉ gắn với học viên qua mahocvien.",
    },
    {
        "from_table": "KyLuat",
        "from_column": "macosodaotao",
        "to_table": "cosogiaoducdaihoc",
        "to_column": "macosodaotao",
        "type": "inferred-business-key",
        "conceptual": True,
        "note": "Kỷ luật liên kết với cơ sở đào tạo ban hành.",
    },
]


def normalize_name(name):
    return re.sub(r"[^a-z0-9]+", "", name.lower())


def snake_to_title(name):
    spaced = re.sub(r"[_]+", " ", name)
    spaced = re.sub(r"(?<=[a-z])(?=[A-Z])", " ", spaced)
    return spaced[:1].upper() + spaced[1:]


def base_entity_name(table_name):
    lowered = table_name.lower()
    suffixes = [
        "_nguoivn_giaytodinhdanhcn",
        "_congdannuocngoai_giaytodinhdanhnn",
        "_doituongsohuu_nguoivn",
        "_doituongsohuu_dinhdanhtochuc",
        "_nguoivn",
        "_congdannuocngoai",
        "_thongtinhieuchinh",
        "_quyetdinhthoihocbaoluu",
    ]
    for suffix in suffixes:
        if lowered.endswith(suffix):
            return table_name[: -len(suffix)]

    pascal_suffixes = [
        "_NguoiVN_GiayToDinhDanhCN",
        "_CongDanNuocNgoai_GiayToDinhDanhNN",
        "_NguoiVN",
        "_CongDanNuocNgoai",
        "_ThongTinHieuChinh",
        "_QuyetDinhThoiHocBaoLuu",
    ]
    for suffix in pascal_suffixes:
        if table_name.endswith(suffix):
            return table_name[: -len(suffix)]
    return table_name


def table_role(table_name):
    lowered = table_name.lower()
    if "giaytodinhdanh" in lowered:
        return "identity-document subtype"
    if lowered.endswith("_nguoivn") or lowered.endswith("_congdannuocngoai"):
        return "person-nationality subtype"
    if "_doituongsohuu_" in lowered:
        return "ownership subtype"
    if lowered.endswith("_thongtinhieuchinh"):
        return "change/history detail"
    if lowered.endswith("_quyetdinhthoihocbaoluu"):
        return "decision detail"
    return "core"


def classify_domain(table_name):
    lowered = table_name.lower()
    for domain, tokens in DOMAIN_RULES:
        if any(token in lowered for token in tokens):
            return domain
    return "Reference / Other"


def classify_table(table_name):
    lowered = table_name.lower()
    if any(token in lowered for token in ["_nguoivn", "_congdannuocngoai", "giaytodinhdanh", "_doituongsohuu_"]):
        return "sub_entity_extension"
    for class_name, table_names in TABLE_CLASS_RULES.items():
        if table_name in table_names:
            return class_name
    return "reference_or_other" if table_role(table_name) != "core" else "core_or_fact"


def looks_like_reference_column(column_name):
    lowered = column_name.lower()
    return (
        lowered in {"dantoc", "tongiao", "quocgia", "quoctich", "maxa", "matinh", "gioitinh"}
        or lowered.startswith(REFERENCE_COLUMN_PREFIXES)
    )


def column_business_score(column):
    name = column.name.lower()
    if name in TECHNICAL_COLUMNS:
        return 0
    if column.key == "PK":
        return 1
    if column.key == "FK":
        return 2
    if column.description:
        return 4
    return 3


def build_relationships(tables, lookup):
    relationships = []
    for table_name, columns in tables.items():
        for column in uniquify_columns(columns):
            if column.key != "FK":
                continue
            target_tables = lookup.get(clean_ident(column.source_name).lower(), [])
            target_tables = [target for target in target_tables if target != table_name]
            if len(target_tables) != 1:
                continue
            target_table = target_tables[0]
            relationships.append(
                {
                    "from_table": table_name,
                    "from_column": column.name,
                    "to_table": target_table,
                    "to_column": clean_ident(column.source_name),
                    "type": "foreign-key",
                    "conceptual": should_keep_conceptual_relationship(table_name, target_table, column.name),
                }
            )
    available_tables = set(tables)
    available_columns = {
        table: {column.name for column in uniquify_columns(columns)}
        for table, columns in tables.items()
    }
    for rel in INFERRED_CONCEPTUAL_RELATIONSHIPS:
        if (
            rel["from_table"] in available_tables
            and rel["to_table"] in available_tables
            and rel["from_column"] in available_columns[rel["from_table"]]
            and rel["to_column"] in available_columns[rel["to_table"]]
        ):
            rel_key = (rel["from_table"], rel["from_column"], rel["to_table"], rel["to_column"])
            existing = {
                (item["from_table"], item["from_column"], item["to_table"], item["to_column"])
                for item in relationships
            }
            if rel_key not in existing:
                relationships.append(dict(rel))
    return relationships


def should_keep_conceptual_relationship(from_table, to_table, column_name):
    if column_name in NATURAL_KEY_REFERENCES:
        return True
    if base_entity_name(from_table).lower() == to_table.lower():
        return True
    if from_table.lower().startswith(to_table.lower() + "_"):
        return True
    return True


def build_metadata(workbook=None):
    tables, dropped_tables = load_tables(workbook)
    lookup = pk_lookup(tables)
    relationships = build_relationships(tables, lookup)

    # Tự động detect suffix tables: nếu tên bảng B bắt đầu bằng tên bảng A + "_"
    # thì B là extension của A (ví dụ: thongtinhocsinh_thongtincha → thongtinhocsinh)
    table_names_lower = {t.lower(): t for t in tables}
    suffix_to_base = {}  # raw_table_name → base_table_name
    for t in tables:
        for other in tables:
            if t != other and t.lower().startswith(other.lower() + "_"):
                # Chọn base dài nhất (tránh match quá rộng)
                prev = suffix_to_base.get(t, "")
                if len(other) > len(prev):
                    suffix_to_base[t] = other

    def resolve_base(table_name):
        # Transitive resolution: A→B→root
        seen_chain = set()
        current = table_name
        while current in suffix_to_base:
            nxt = suffix_to_base[current]
            if nxt in seen_chain:
                break
            seen_chain.add(current)
            current = nxt
        return current if current != table_name else base_entity_name(table_name)

    table_items = OrderedDict()
    entity_groups = OrderedDict()
    domain_map = defaultdict(list)

    for table_name, raw_columns in tables.items():
        columns = uniquify_columns(raw_columns)
        domain = classify_domain(table_name)
        base_name = resolve_base(table_name)
        entity_name = ENTITY_LABELS.get(base_name, ENTITY_LABELS.get(table_name, snake_to_title(base_name)))
        domain_map[domain].append(table_name)
        entity_groups.setdefault(
            entity_name,
            {
                "entity": entity_name,
                "base_table": base_name,
                "domain": classify_domain(base_name),
                "tables": [],
                "business_attributes": OrderedDict(),
            },
        )
        entity_groups[entity_name]["tables"].append({"table": table_name, "role": table_role(table_name)})

        business_columns = [
            column
            for column in sorted(columns, key=lambda item: (-column_business_score(item), item.name))
            if column.name.lower() not in TECHNICAL_COLUMNS
        ][:18]
        for column in business_columns:
            entity_groups[entity_name]["business_attributes"].setdefault(
                column.name,
                {
                    "name": column.name,
                    "type": column.col_type,
                    "key": column.key,
                    "description": column.description,
                    "source_table": table_name,
                },
            )

        table_items[table_name] = {
            "name": table_name,
            "classification": classify_table(table_name),
            "domain": domain,
            "entity": entity_name,
            "role": table_role(table_name),
            "columns": [asdict(column) for column in columns],
            "pk": [column.name for column in columns if column.key == "PK"],
            "fk": [column.name for column in columns if column.key == "FK"],
            "reference_like_columns": [
                column.name
                for column in columns
                if looks_like_reference_column(column.name) and column.name.lower() not in TECHNICAL_COLUMNS
            ],
        }

    for entity in entity_groups.values():
        entity["business_attributes"] = list(entity["business_attributes"].values())

    return {
        "source": "Book1.xlsx",
        "tables": table_items,
        "dropped_duplicate_tables": dropped_tables,
        "relationships": relationships,
        "entities": list(entity_groups.values()),
        "domain_map": dict(sorted(domain_map.items())),
        "review_notes": build_review_notes(table_items, relationships),
        "_tables": tables,          # raw Column objects — dùng cho LLM CDM design
        "_suffix_to_base": suffix_to_base,  # raw_table → base_table mapping
    }


def build_review_notes(tables, relationships):
    fk_columns = sum(len(table["fk"]) for table in tables.values())
    return [
        f"Physical tables retained after lowercase de-duplication: {len(tables)}.",
        f"FK columns marked in Excel: {fk_columns}; resolved conceptual/physical relationships: {len(relationships)}.",
        "Many lookup-style FK columns are still unresolved because their reference/dictionary tables are not present in the workbook.",
        "Subtype tables for Vietnamese/foreign people and identity documents are collapsed into their parent conceptual entities.",
    ]


def write_json(metadata):
    serializable = {k: v for k, v in metadata.items() if not k.startswith("_")}
    (OUTPUT_DIR / "metadata_extraction.json").write_text(
        json.dumps(serializable, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def write_pipeline_overview(metadata):
    lines = [
        "# CDM Agent Pipeline",
        "",
        "This folder is generated from `Book1.xlsx` and follows the requested seven-agent flow.",
        "",
        "| Step | Agent | Output | Purpose |",
        "| --- | --- | --- | --- |",
        "| 1 | Metadata Extractor | `metadata_extraction.json` | Raw tables, columns, keys, descriptions, relationships |",
        "| 2 | Table Classifier | `table_classifier.md` | Physical table class: core, event, extension, asset, organization |",
        "| 3 | Business Entity Grouper | `business_entity_groups.md` | Collapsed business entities from one or more physical tables |",
        "| 4 | Relationship Simplifier | `relationship_simplification.md` | Conceptual vs implementation relationships |",
        "| 5 | Subject Area Mapper | `domain_map.md` | Subject areas/domains and table coverage |",
        "| 6 | Conceptual Model Generator | `cdm.md`, `cdm_erd.mmd`, `cdm.drawio`, `glossary.md` | CDM, Mermaid, Draw.io, glossary |",
        "| 7 | Reviewer / Human Approval | `reviewer_approval.md` | Open decisions and approval checklist |",
        "",
        "Current run summary:",
        f"- Tables retained: {len(metadata['tables'])}",
        f"- Business entities: {len(metadata['entities'])}",
        f"- Relationships: {len(metadata['relationships'])}",
        f"- Dropped duplicate mixed-case tables: {len(metadata['dropped_duplicate_tables'])}",
        "",
    ]
    (OUTPUT_DIR / "pipeline.md").write_text("\n".join(lines), encoding="utf-8")


def write_table_classifier(metadata):
    grouped = defaultdict(list)
    for table in metadata["tables"].values():
        grouped[table["classification"]].append(table["name"])

    lines = ["# Agent 2: Table Classifier", ""]
    for class_name in [
        "core_entity",
        "transaction_or_event",
        "sub_entity_extension",
        "asset_facility",
        "organization_structure",
        "core_or_fact",
        "reference_or_other",
    ]:
        if class_name not in grouped:
            continue
        lines.append(f"## {class_name}")
        for table_name in sorted(grouped[class_name], key=str.lower):
            table = metadata["tables"][table_name]
            refs = ", ".join(table["reference_like_columns"][:12])
            suffix = f" Reference-like columns: {refs}." if refs else ""
            lines.append(f"- `{table_name}`: {table['domain']}; role `{table['role']}`.{suffix}")
        lines.append("")
    (OUTPUT_DIR / "table_classifier.md").write_text("\n".join(lines), encoding="utf-8")


def write_business_entity_groups(metadata):
    lines = ["# Agent 3: Business Entity Grouper", ""]
    for entity in metadata["entities"]:
        lines.append(f"## {entity['entity']}")
        lines.append(f"- Domain: {entity['domain']}")
        lines.append("- Physical tables:")
        for table in entity["tables"]:
            lines.append(f"  - `{table['table']}`: {table['role']}")
        lines.append("- Collapse rule:")
        if any("nguoivn" in item["table"].lower() or "congdannuocngoai" in item["table"].lower() for item in entity["tables"]):
            lines.append("  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.")
        elif any("giaytodinhdanh" in item["table"].lower() for item in entity["tables"]):
            lines.append("  - Identity-document rows are modeled as repeatable components.")
        else:
            lines.append("  - Keep as a top-level conceptual entity or fact.")
        lines.append("")
    (OUTPUT_DIR / "business_entity_groups.md").write_text("\n".join(lines), encoding="utf-8")


def write_relationship_simplification(metadata):
    lines = ["# Agent 4: Relationship Simplifier", ""]
    lines.append("## Conceptual Relationships")
    for rel in metadata["relationships"]:
        if rel["conceptual"]:
            note = f" {rel['note']}" if rel.get("note") else ""
            lines.append(
                f"- `{rel['from_table']}.{rel['from_column']}` -> "
                f"`{rel['to_table']}.{rel['to_column']}` ({rel['type']}).{note}"
            )
    lines.append("")
    lines.append("## Simplification Rules")
    lines.append("- Treat `key*` joins from subtype tables to parent tables as implementation nesting unless the child is a repeated business fact.")
    lines.append("- Collapse `_nguoivn` and `_congdannuocngoai` into the parent entity with citizenship/person-type attributes.")
    lines.append("- Collapse `_giaytodinhdanh*` into repeatable `IdentityDocument` components.")
    lines.append("- Keep decisions, corrections, ownership, reward, discipline, study, work, and training history as business facts.")
    lines.append("- Keep `macosodaotao` as the main Institution relationship.")
    (OUTPUT_DIR / "relationship_simplification.md").write_text("\n".join(lines), encoding="utf-8")


def write_reviewer_approval(metadata):
    unresolved_reference_columns = sorted(
        {
            column
            for table in metadata["tables"].values()
            for column in table["reference_like_columns"]
            if column not in {"macosodaotao", "mahocvien"}
        }
    )
    lines = ["# Agent 7: Reviewer / Human Approval", ""]
    lines.append("## Decisions To Approve")
    lines.append("- Approve lowercase table preference and removal of mixed-case duplicates.")
    lines.append("- Approve collapsing VN/foreign person detail tables into one conceptual person/profile component.")
    lines.append("- Approve inferred business-key relationships such as `mahocvien` and `macosodaotao`.")
    lines.append("- Decide whether entity names should be English business names or Vietnamese official terms.")
    lines.append("")
    lines.append("## Missing Reference Data")
    for column in unresolved_reference_columns[:80]:
        lines.append(f"- `{column}`")
    lines.append("")
    lines.append("## Sign-off")
    lines.append("- [ ] Metadata extraction accepted")
    lines.append("- [ ] Table classification accepted")
    lines.append("- [ ] Business entity grouping accepted")
    lines.append("- [ ] Relationship simplification accepted")
    lines.append("- [ ] Subject area map accepted")
    lines.append("- [ ] CDM / Glossary / ERD accepted")
    (OUTPUT_DIR / "reviewer_approval.md").write_text("\n".join(lines), encoding="utf-8")


def write_domain_map(metadata):
    lines = ["# Domain Map", ""]
    for domain, tables in metadata["domain_map"].items():
        lines.append(f"## {domain}")
        for table in tables:
            lines.append(f"- `{table}` -> {metadata['tables'][table]['entity']} ({metadata['tables'][table]['role']})")
        lines.append("")
    (OUTPUT_DIR / "domain_map.md").write_text("\n".join(lines), encoding="utf-8")


def write_glossary(metadata):
    lines = ["# Business Glossary", ""]
    for entity in metadata["entities"]:
        lines.append(f"## {entity['entity']}")
        lines.append(f"- Domain: {entity['domain']}")
        lines.append(f"- Source tables: {', '.join('`' + item['table'] + '`' for item in entity['tables'])}")
        lines.append("")
        for attr in entity["business_attributes"][:12]:
            desc = attr["description"].replace("\n", " ") if attr["description"] else "TBD"
            key = f" [{attr['key']}]" if attr["key"] else ""
            lines.append(f"- `{attr['name']}`{key}: {desc}")
        lines.append("")
    (OUTPUT_DIR / "glossary.md").write_text("\n".join(lines), encoding="utf-8")


def write_cdm(metadata):
    lines = ["# Conceptual Data Model", ""]
    lines.extend(f"- {note}" for note in metadata["review_notes"])
    lines.append("")
    lines.append("## Conceptual Entities")
    for entity in metadata["entities"]:
        lines.append(f"### {entity['entity']}")
        lines.append(f"- Domain: {entity['domain']}")
        lines.append(f"- Physical coverage: {', '.join(item['table'] + ' (' + item['role'] + ')' for item in entity['tables'])}")
        attrs = ", ".join(attr["name"] for attr in entity["business_attributes"][:10])
        lines.append(f"- Key business attributes: {attrs}")
        lines.append("")

    lines.append("## Conceptual Relationships")
    for rel in metadata["relationships"]:
        if rel["conceptual"]:
            note = f" ({rel['type']})" if rel["type"] != "foreign-key" else ""
            lines.append(
                f"- `{rel['from_table']}.{rel['from_column']}` -> "
                f"`{rel['to_table']}.{rel['to_column']}`{note}"
            )
    lines.append("")
    lines.append("## Human Approval Checklist")
    lines.append("- Confirm unresolved lookup/reference FK targets such as province, commune, nationality, gender, religion, major, training level.")
    lines.append("- Confirm whether technical audit columns should be excluded from downstream conceptual diagrams.")
    lines.append("- Confirm naming language: English entity names vs Vietnamese official terms.")
    (OUTPUT_DIR / "cdm.md").write_text("\n".join(lines), encoding="utf-8")


def mermaid_entity_id(name):
    return re.sub(r"[^A-Za-z0-9_]", "_", name)


def write_mermaid(metadata):
    lines = ["erDiagram"]
    entity_ids = {}
    for entity in metadata["entities"]:
        entity_id = mermaid_entity_id(entity["entity"])
        entity_ids[entity["entity"]] = entity_id
        lines.append(f"  {entity_id} {{")
        for attr in entity["business_attributes"][:10]:
            data_type = attr["type"].split("(")[0].lower()
            key = " PK" if attr["key"] == "PK" else " FK" if attr["key"] == "FK" else ""
            lines.append(f"    {data_type} {mermaid_entity_id(attr['name'])}{key}")
        lines.append("  }")

    emitted = set()
    table_to_entity = {table: item["entity"] for table, item in metadata["tables"].items()}
    for rel in metadata["relationships"]:
        left = table_to_entity.get(rel["to_table"])
        right = table_to_entity.get(rel["from_table"])
        if not left or not right or left == right:
            continue
        edge = (left, right)
        if edge in emitted:
            continue
        emitted.add(edge)
        lines.append(f"  {entity_ids[left]} ||--o{{ {entity_ids[right]} : relates_to")

    (OUTPUT_DIR / "cdm_erd.mmd").write_text("\n".join(lines) + "\n", encoding="utf-8")


def write_drawio(metadata):
    table_style = (
        "swimlane;fontStyle=0;childLayout=stackLayout;horizontal=1;startSize=30;"
        "horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;"
        "marginBottom=0;whiteSpace=wrap;html=1;fillColor=#008000;swimlaneFillColor=#ffffff;"
        "strokeColor=#6aa56a;fontColor=#ffffff;fontSize=13;fontStyle=1;"
    )
    row_style = (
        "text;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;"
        "spacingLeft=4;spacingRight=4;overflow=hidden;"
        "points=[[0,0.5],[1,0.5]];portConstraint=eastwest;rotatable=0;fontSize=11;"
        "fontColor=#000000;"
    )
    edge_style = (
        "edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;"
        "html=1;fontSize=13;labelBackgroundColor=#ffffff;endArrow=block;endFill=1;"
    )
    cells = [
        '<mxCell id="0" />',
        '<mxCell id="1" parent="0" />',
    ]
    entity_positions = {}
    node_geometry = {}
    preferred_positions = {
        "cosogiaoducdaihoc": (60, 760),
        "thongtincocautochuc": (560, 80),
        "thongtintoanha": (560, 330),
        "csvcvatrangthietbidatdai": (560, 580),
        "phonghocgiangduongvahoitruong": (560, 830),
        "DanhSachNganhDaoTao": (560, 1080),
        "ChuongTrinhDaoTao": (560, 1330),
        "ttchunghocvien": (1080, 330),
        "thongtinhoctapsvdh": (1600, 80),
        "VanBangChungChi": (1600, 330),
        "KhenThuong": (1600, 580),
        "KyLuat": (1600, 830),
        "ThongTinCanBoGiangVien": (1080, 1330),
        "PhongBanDonViCongTac": (1600, 1180),
        "QuaTrinhCongTacCuaCanBoGiangVien": (1600, 1430),
        "QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien": (1600, 1680),
    }
    entities = sorted(
        metadata["entities"],
        key=lambda item: (
            preferred_positions.get(item["base_table"], (9999, 9999))[1],
            preferred_positions.get(item["base_table"], (9999, 9999))[0],
            item["base_table"],
        ),
    )
    width = 300
    row_height = 24
    fallback_x = 60
    fallback_y = 1940

    for index, entity in enumerate(entities, start=2):
        entity_id = f"e{index}"
        entity_positions[entity["entity"]] = entity_id
        x, y = preferred_positions.get(entity["base_table"], (fallback_x, fallback_y))
        if entity["base_table"] not in preferred_positions:
            fallback_x += 380
            if fallback_x > 1600:
                fallback_x = 60
                fallback_y += 220

        identity_columns = select_identity_columns(entity, metadata)
        height = 30 + len(identity_columns) * row_height
        label = html.escape(entity["base_table"])
        cells.append(
            f'<mxCell id="{entity_id}" value="{label}" style="{table_style}" vertex="1" parent="1">'
            f'<mxGeometry x="{x}" y="{y}" width="{width}" height="{height}" as="geometry" /></mxCell>'
        )
        node_geometry[entity_id] = (x, y, width, height)
        for attr_index, attr in enumerate(identity_columns, start=1):
            row_id = f"{entity_id}_c{attr_index}"
            key = f" ({attr['key']})" if attr.get("key") else ""
            value = html.escape(f"{attr['name']}{key}")
            cells.append(
                f'<mxCell id="{row_id}" value="{value}" style="{row_style}" vertex="1" parent="{entity_id}">'
                f'<mxGeometry y="{attr_index * row_height}" width="{width}" height="{row_height}" as="geometry" /></mxCell>'
            )

    table_to_entity = {table: item["entity"] for table, item in metadata["tables"].items()}
    edge_index = 1000
    emitted = set()
    lane_counts = defaultdict(int)
    source_counts = defaultdict(int)
    target_counts = defaultdict(int)
    for rel in metadata["relationships"]:
        source_entity = table_to_entity.get(rel["to_table"])
        target_entity = table_to_entity.get(rel["from_table"])
        if not source_entity or not target_entity or source_entity == target_entity:
            continue
        if not should_draw_relationship(rel, source_entity, target_entity):
            continue
        edge = (source_entity, target_entity)
        if edge in emitted:
            continue
        emitted.add(edge)
        edge_index += 1
        cardinality = infer_cardinality(rel, metadata)
        lane_key = edge_lane_key(entity_positions[source_entity], entity_positions[target_entity], node_geometry)
        lane_index = lane_counts[lane_key]
        lane_counts[lane_key] += 1
        source_id = entity_positions[source_entity]
        target_id = entity_positions[target_entity]
        source_slot = source_counts[source_id]
        target_slot = target_counts[target_id]
        source_counts[source_id] += 1
        target_counts[target_id] += 1
        cells.append(
            drawio_edge_cell(
                f"r{edge_index}",
                cardinality,
                edge_style,
                source_id,
                target_id,
                node_geometry,
                lane_index,
                source_slot,
                target_slot,
            )
        )

    for source_entity, target_entity, cardinality, label in inferred_summary_edges(entity_positions):
        edge = (source_entity, target_entity)
        if edge in emitted:
            continue
        emitted.add(edge)
        edge_index += 1
        value = html.escape(cardinality)
        lane_key = edge_lane_key(entity_positions[source_entity], entity_positions[target_entity], node_geometry)
        lane_index = lane_counts[lane_key]
        lane_counts[lane_key] += 1
        source_id = entity_positions[source_entity]
        target_id = entity_positions[target_entity]
        source_slot = source_counts[source_id]
        target_slot = target_counts[target_id]
        source_counts[source_id] += 1
        target_counts[target_id] += 1
        cells.append(
            drawio_edge_cell(
                f"r{edge_index}",
                value,
                f"{edge_style}dashed=1;",
                source_id,
                target_id,
                node_geometry,
                lane_index,
                source_slot,
                target_slot,
            )
        )
    legend_id = "legend_cardinality"
    legend_value = html.escape("Bội số\n1-n\nn-n")
    cells.append(
        f'<mxCell id="{legend_id}" value="{legend_value}" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fff8;strokeColor=#6aa56a;fontSize=12;" vertex="1" parent="1">'
        '<mxGeometry x="60" y="2050" width="180" height="80" as="geometry" /></mxCell>'
    )

    xml = (
        '<mxfile host="app.diagrams.net" pages="1"><diagram name="CDM">'
        '<mxGraphModel grid="1" page="1" gridSize="10" guides="1" tooltips="1" connect="1" '
        'arrows="1" fold="1" pageScale="1" pageWidth="2200" pageHeight="2250" math="0" shadow="0"><root>'
        + "".join(cells)
        + "</root></mxGraphModel></diagram></mxfile>"
    )
    (OUTPUT_DIR / "cdm.drawio").write_text(xml, encoding="utf-8")


# ── LLM CDM Design Helpers ───────────────────────────────────────────────────

# Suffix patterns to collapse into base table (longest match first)
_LLM_SUFFIX_PATTERNS = sorted([
    "_nguoivn_giaytodinhdanhcn", "_congdannuocngoai_giaytodinhdanhnn",
    "_doituongsohuu_nguoivn", "_doituongsohuu_dinhdanhtochuc",
    "_nguoivn", "_congdannuocngoai",
    "_cha", "_me", "_thongtincha", "_thongtinme", "_nguoidodau",
    "_khenthuong", "_kyluat",
    "_diemmon", "_monday", "_monkiemnhiem", "_ngoaingu",
    "_thongtinhieuchinh", "_quyetdinhthoihocbaoluu",
], key=len, reverse=True)

# System context: domain knowledge injected before the user prompt
_LLM_SYSTEM = (
    "Bạn là chuyên gia thiết kế Conceptual Data Model (CDM) cho hệ thống thông tin giáo dục Việt Nam.\n"
    "Domain chính: cơ sở giáo dục (ĐH, phổ thông, mầm non, GDTX), tổ chức nội bộ, "
    "cơ sở vật chất, chương trình học, người học, kết quả học tập, nhân sự, thi đua - kỷ luật.\n"
    "Suffix tables (_NguoiVN, _CongDanNuocNgoai, _GiayToDinhDanh, _cha, _me, _khenthuong, "
    "_kyluat, _diemmon, _monday, _monkiemnhiem, _ngoaingu, _ThongTinHieuChinh, "
    "_QuyetDinhThoiHocBaoLuu) luôn được gộp vào entity gốc."
)

# Tool schema for Anthropic — forces structured JSON output without regex fragility
_CDM_TOOL_SCHEMA = {
    "name": "design_cdm",
    "description": "Xuất CDM design có cấu trúc JSON từ phân tích schema DB",
    "input_schema": {
        "type": "object",
        "properties": {
            "reasoning": {
                "type": "string",
                "description": "Tóm tắt cách nhóm bảng và xác định entity chính (3-6 câu)",
            },
            "entities": {
                "type": "array",
                "items": {
                    "type": "object",
                    "properties": {
                        "display_name":  {"type": "string", "description": "Tên tiếng Việt 2-4 từ"},
                        "base_table":    {"type": "string", "description": "Tên bảng gốc CHÍNH XÁC trong DB"},
                        "merged_tables": {"type": "array", "items": {"type": "string"}},
                        "domain":        {"type": "string"},
                    },
                    "required": ["display_name", "base_table", "merged_tables", "domain"],
                },
            },
            "relationships": {
                "type": "array",
                "items": {
                    "type": "object",
                    "properties": {
                        "from_table": {"type": "string"},
                        "to_table":   {"type": "string"},
                        "type":       {"type": "string", "enum": ["1-1", "1-n", "n-n"]},
                        "label":      {"type": "string", "description": "Động từ tiếng Việt ngắn"},
                    },
                    "required": ["from_table", "to_table", "type", "label"],
                },
            },
            "domains": {
                "type": "array",
                "items": {
                    "type": "object",
                    "properties": {
                        "name":         {"type": "string"},
                        "fill_color":   {"type": "string"},
                        "stroke_color": {"type": "string"},
                    },
                    "required": ["name", "fill_color", "stroke_color"],
                },
            },
        },
        "required": ["entities", "relationships", "domains"],
    },
}


def _compress_tables_for_llm(tables):
    """Nén danh sách bảng cho LLM context.

    - Gộp suffix tables vào base (giảm ~40-60% token)
    - Giữ lại descriptions của PK/FK để LLM hiểu ngữ nghĩa
    - Hiển thị subtables dạng ~suffix để LLM biết cần gộp vào merged_tables
    """
    def find_base(name):
        nl = name.lower()
        for s in _LLM_SUFFIX_PATTERNS:
            if nl.endswith(s) and len(nl) > len(s):
                return name[: -len(s)]
        return name

    groups: dict = {}
    for name, cols in tables.items():
        base = find_base(name)
        grp = groups.setdefault(base, {"cols": None, "subtables": []})
        if base == name:
            grp["cols"] = cols
        else:
            grp["subtables"].append(name)
            if grp["cols"] is None:
                grp["cols"] = cols

    lines = []
    for base, info in groups.items():
        cols = info["cols"] or []
        pk   = [c.name for c in cols if c.key == "PK"]
        fk   = [c.name for c in cols if c.key == "FK"]
        ma   = [c.name for c in cols if c.key not in ("PK", "FK") and c.name.lower().startswith("ma")][:4]
        descs = [
            f"{c.name}:{(c.description or '').split(chr(10))[0][:45]}"
            for c in cols if c.key in ("PK", "FK") and c.description
        ][:3]
        parts: list[str] = []
        if pk:    parts.append(f"PK={','.join(pk)}")
        if fk:    parts.append(f"FK={','.join(fk)}")
        if ma:    parts.append(f"ma={','.join(ma)}")
        if descs: parts.append(f"desc=[{'; '.join(descs)}]")
        if info["subtables"]:
            short = [s.replace(base, "~") for s in info["subtables"]]
            parts.append(f"subs=[{','.join(short)}]")
        lines.append(f"  {base}: {'; '.join(parts)}")

    return "\n".join(lines), len(groups)


def _build_llm_prompt(table_context: str, n_groups: int) -> str:
    return (
        f"Phân tích {n_groups} entity group từ schema DB giáo dục Việt Nam:\n\n"
        f"{table_context}\n\n"
        "Thực hiện từng bước trước khi xuất kết quả:\n"
        "1. Xác định các entity nghiệp vụ chính (bỏ qua suffix tables — chúng đã được gộp).\n"
        "2. Phân nhóm thành 6-8 domain; mỗi domain 4-8 entities; tổng 25-40 entities.\n"
        "3. Xác định quan hệ nghiệp vụ giữa entities (không copy FK kỹ thuật).\n"
        "4. Đặt display_name tiếng Việt ngắn gọn (2-4 từ): 'Trường học', 'Học sinh', 'Lớp học'.\n\n"
        "Ràng buộc:\n"
        "- base_table PHẢI khớp chính xác tên bảng trong danh sách (không sửa chính tả).\n"
        "- merged_tables gồm base_table + tất cả subs[] liệt kê ở dòng đó.\n"
        "- Quan hệ chỉ dùng base_table, không dùng suffix table.\n"
        "- Màu domain dùng pastel: #dae8fc #d5e8d4 #fff2cc #ffe6cc #e1d5e7 #f8cecc #e0f0e0 #f0f0f0."
    )


def design_cdm_with_llm(tables):
    """Gọi LLM API để thiết kế CDM với context nén, CoT và tool use."""
    import os, json as _json, re as _re

    raw_openai    = os.environ.get("OPENAI_API_KEY", "").strip()
    raw_anthropic = os.environ.get("ANTHROPIC_API_KEY", "").strip()

    # Route theo prefix de chong nham key giua 2 bien moi truong:
    #   sk-ant-... = Anthropic | sk-proj-.../sk-... = OpenAI
    anthropic_key = None
    openai_key    = None
    for k in (raw_anthropic, raw_openai):
        if not k:
            continue
        if k.startswith("sk-ant"):
            anthropic_key = anthropic_key or k
        else:
            openai_key = openai_key or k

    # Canh bao neu key dat sai bien
    if raw_anthropic and not raw_anthropic.startswith("sk-ant"):
        print("[LLM CDM] WARNING: ANTHROPIC_API_KEY khong phai key Anthropic (sk-ant-...) — coi nhu OpenAI key")
    if raw_openai and raw_openai.startswith("sk-ant"):
        print("[LLM CDM] WARNING: OPENAI_API_KEY la key Anthropic — coi nhu Anthropic key")

    if not openai_key and not anthropic_key:
        return None

    table_context, n_groups = _compress_tables_for_llm(tables)
    prompt = _build_llm_prompt(table_context, n_groups)
    provider = "Anthropic" if anthropic_key else "OpenAI"
    print(f"[LLM CDM] Calling {provider} — {n_groups} entity groups, {len(table_context)} chars context")

    try:
        # ── Anthropic: tool use đảm bảo JSON có cấu trúc, không cần regex ──
        if anthropic_key:
            import anthropic as _ant
            client = _ant.Anthropic(api_key=anthropic_key)
            print("[LLM CDM] Sending request to claude-sonnet-4-6 ...")
            resp = client.messages.create(
                model="claude-sonnet-4-6",
                max_tokens=6000,
                system=_LLM_SYSTEM,
                tools=[_CDM_TOOL_SCHEMA],
                tool_choice={"type": "tool", "name": "design_cdm"},
                messages=[{"role": "user", "content": prompt}],
            )
            print(f"[LLM CDM] Response received — stop_reason={resp.stop_reason}")
            for block in resp.content:
                if block.type == "tool_use" and block.name == "design_cdm":
                    result = block.input
                    reasoning = result.pop("reasoning", "")
                    if reasoning:
                        print(f"[LLM reasoning] {reasoning[:400]}")
                    print(f"[LLM CDM] Parsed: {len(result.get('entities',[]))} entities, "
                          f"{len(result.get('relationships',[]))} relationships")
                    return result
            print("[LLM CDM] Anthropic: no tool_use block in response")
            return None

        # ── OpenAI: system context + CoT + json_object ───────────────────────
        from openai import OpenAI
        client = OpenAI(api_key=openai_key)
        messages = [
            {"role": "system", "content": _LLM_SYSTEM},
            {"role": "user",   "content": prompt},
        ]
        resp = None
        for model_name in ("gpt-4.1", "gpt-4o"):
            try:
                print(f"[LLM CDM] Sending request to {model_name} ...")
                resp = client.chat.completions.create(
                    model=model_name,
                    max_tokens=6000,
                    response_format={"type": "json_object"},
                    messages=messages,
                )
                break
            except Exception as model_exc:
                msg = str(model_exc)
                if "model" in msg.lower() and ("not" in msg.lower() or "404" in msg or "does not exist" in msg.lower()):
                    print(f"[LLM CDM] {model_name} khong dung duoc, thu model khac... ({msg[:80]})")
                    continue
                raise
        if resp is None:
            print("[LLM CDM] Khong co model OpenAI nao dung duoc")
            return None
        print(f"[LLM CDM] Response received — finish_reason={resp.choices[0].finish_reason}")
        text = resp.choices[0].message.content
        m = _re.search(r'\{[\s\S]*\}', text)
        if m:
            data = _json.loads(m.group())
            print(f"[LLM CDM] Parsed: {len(data.get('entities',[]))} entities, "
                  f"{len(data.get('relationships',[]))} relationships")
            return data
        print("[LLM CDM] OpenAI: no JSON found in response")

    except Exception as exc:
        print(f"[LLM CDM] ERROR: {exc}")
    return None


def layout_cdm_grid(entities):
    """Domain-row layout: mỗi domain 1 hàng ngang, domains xếp dọc.
    Trong mỗi domain, entities sắp xếp từ trái sang phải."""
    domain_order = []
    domain_tables = OrderedDict()
    for e in entities:
        d = e.get("domain", "Khác")
        if d not in domain_tables:
            domain_order.append(d)
            domain_tables[d] = []
        domain_tables[d].append(e["base_table"])

    BOX_W   = 360
    GAP_X   = 80    # khoảng cách ngang giữa các box
    GAP_Y   = 120   # khoảng cách dọc giữa các domain
    BOX_H   = 220   # chiều cao ước tính mỗi box
    START_X = 80
    START_Y = 80

    positions = {}
    current_y = START_Y
    for domain in domain_order:
        tables = domain_tables[domain]
        for i, base_table in enumerate(tables):
            x = START_X + i * (BOX_W + GAP_X)
            positions[base_table] = (x, current_y)
        current_y += BOX_H + GAP_Y
    return positions


def compute_zone_cells_from_positions(entities, positions, domains):
    """Tính toán zone background động từ vị trí entities sau khi layout."""
    PADDING = 24
    W, H_EST = 360, 200  # ước lượng kích thước mỗi entity
    color_map = {d["name"]: (d["fill_color"], d["stroke_color"]) for d in domains}
    domain_bounds = {}
    for e in entities:
        d = e.get("domain", "")
        base = e["base_table"]
        if base not in positions:
            continue
        x, y = positions[base]
        if d not in domain_bounds:
            domain_bounds[d] = [x, y, x + W, y + H_EST]
        else:
            b = domain_bounds[d]
            b[0] = min(b[0], x)
            b[1] = min(b[1], y)
            b[2] = max(b[2], x + W)
            b[3] = max(b[3], y + H_EST)

    style = (
        "rounded=1;whiteSpace=wrap;html=1;verticalAlign=top;align=center;"
        "fontSize=11;fontStyle=1;opacity=40;strokeWidth=1.5;spacingTop=4;"
    )
    cells = []
    for i, (domain, (x1, y1, x2, y2)) in enumerate(domain_bounds.items()):
        fill, stroke = color_map.get(domain, ("#f0f0f0", "#999999"))
        cells.append(
            f'<mxCell id="zone_{i}" value="{html.escape(domain)}" '
            f'style="{style}fillColor={fill};strokeColor={stroke};" vertex="1" parent="1">'
            f'<mxGeometry x="{x1 - PADDING}" y="{y1 - PADDING}" '
            f'width="{x2 - x1 + 2*PADDING}" height="{y2 - y1 + 2*PADDING}" as="geometry" /></mxCell>'
        )
    return cells


def build_entities_from_llm(llm_design, tables, metadata_tables):
    """Chuyển LLM CDM design sang danh sách entities cho build_drawio_page."""
    table_keys_lower = {k.lower(): k for k in tables}
    entities = []
    for e in llm_design.get("entities", []):
        raw_base = e.get("base_table", "")
        # Tìm key thực sự trong tables (case-insensitive)
        base_table = table_keys_lower.get(raw_base.lower(), raw_base)
        if base_table not in tables:
            continue
        # Lấy business_attributes từ bảng gốc (dùng metadata_tables nếu có)
        mt = metadata_tables.get(base_table)
        if mt:
            attrs = mt.get("columns", [])
        else:
            attrs = [{"name": c.name, "key": c.key, "description": c.description}
                     for c in tables[base_table]]
        entities.append({
            "entity": base_table,   # giữ tên bảng gốc từ Excel
            "base_table": base_table,
            "domain": e.get("domain", ""),
            "tables": [{"table": t, "role": "extension" if t != base_table else "core"}
                       for t in e.get("merged_tables", [base_table])],
            "business_attributes": attrs,
        })
    return entities


def load_cdm_config():
    """Doc cdm_config.json neu ton tai."""
    import os
    cfg_path = Path(__file__).parent / "cdm_config.json"
    if cfg_path.exists():
        with open(cfg_path, encoding="utf-8") as f:
            return json.load(f)
    return None


def _is_garbage_table(name):
    """Lọc bỏ tên bảng là data-type hoặc artifact từ Excel (decimal__, số, ký tự đặc biệt)."""
    lower = name.lower()
    if lower.startswith("decimal") or lower.startswith("numeric") or lower.startswith("varchar"):
        return True
    if re.match(r'^[\d,\.\(\)_]+$', name):
        return True
    return False


def write_drawio_dbeaver_style(metadata):
    import os
    raw_tables = metadata.get("_tables")
    force_llm = os.environ.get("CDM_FORCE_LLM", "").strip() in ("1", "true", "yes")
    if force_llm:
        print("[CDM] CDM_FORCE_LLM set — bo qua cdm_config.json, uu tien LLM")

    # === CONFIG PATH: dùng cdm_config.json nếu có (tru khi CDM_FORCE_LLM) ===
    config = None if force_llm else load_cdm_config()
    if config and config.get("entities"):
        print(f"[CDM] Using cdm_config.json: {len(config['entities'])} entities defined")
        entities = build_entities_from_llm(config, raw_tables or {}, metadata["tables"])
        if entities:
            print(f"[CDM] Matched {len(entities)} entities from config")
            # Thêm các entity chưa được config cover (bảng không có trong cdm_config.json)
            config_bases = {e["base_table"] for e in entities}
            for meta_e in metadata["entities"]:
                if meta_e["base_table"] not in config_bases and not _is_garbage_table(meta_e["base_table"]):
                    entities.append({
                        "entity": meta_e["base_table"],
                        "base_table": meta_e["base_table"],
                        "domain": meta_e.get("domain", "Reference / Other"),
                        "tables": meta_e["tables"],
                        "business_attributes": meta_e["business_attributes"],
                    })
            print(f"[CDM] Total entities after adding uncovered: {len(entities)}")
            edges = [
                (r["from_table"], r["to_table"], f"{r.get('type','1-n')}  {r.get('label','')}")
                for r in config.get("relationships", [])
            ]
            # Thêm auto-detect edges cho các entity ngoài config
            s2b = metadata.get("_suffix_to_base", {})
            all_bases = {e["base_table"] for e in entities}
            seen_edges = {(f, t) for f, t, _ in edges}
            for r in metadata["relationships"]:
                f = s2b.get(r["from_table"], r["from_table"])
                t = s2b.get(r["to_table"], r["to_table"])
                if f == t or f not in all_bases or t not in all_bases:
                    continue
                if (f, t) not in seen_edges:
                    seen_edges.add((f, t))
                    edges.append((f, t, "1-n"))
            domains = config.get("domains", [
                {"name": "Reference / Other", "fill_color": "#f5f5f5", "stroke_color": "#666666"},
            ])
            # Thêm màu cho domain chưa có trong config
            domain_colors = {d["name"]: d for d in domains}
            extra_colors = [
                ("#dae8fc", "#6c8ebf"), ("#d5e8d4", "#82b366"), ("#fff2cc", "#d6b656"),
                ("#ffe6cc", "#d79b00"), ("#e1d5e7", "#9673a6"), ("#f8cecc", "#b85450"),
            ]
            color_idx = 0
            for e in entities:
                d = e.get("domain", "Reference / Other")
                if d not in domain_colors:
                    fill, stroke = extra_colors[color_idx % len(extra_colors)]
                    domains.append({"name": d, "fill_color": fill, "stroke_color": stroke})
                    domain_colors[d] = domains[-1]
                    color_idx += 1
            positions = layout_cdm_grid(entities)
            zone_cells = compute_zone_cells_from_positions(entities, positions, domains)
            diagram = build_drawio_page("CDM", entities, edges, metadata,
                                        layout="cdm", zone_cells=zone_cells,
                                        cdm_positions=positions)
            xml = '<mxfile host="app.diagrams.net" pages="1">' + diagram + "</mxfile>"
            (OUTPUT_DIR / "cdm.drawio").write_text(xml, encoding="utf-8")
            return
        else:
            print("[CDM] cdm_config.json tables do not match current file — falling through to LLM/fallback")

    # === LLM PATH: dùng khi có ANTHROPIC_API_KEY ===
    if raw_tables:
        print("[CDM] Calling LLM to design CDM...")
        llm_design = design_cdm_with_llm(raw_tables)
    else:
        llm_design = None

    if llm_design and llm_design.get("entities"):
        print(f"[CDM] LLM returned {len(llm_design['entities'])} entities, "
              f"{len(llm_design.get('relationships', []))} relationships")
        entities = build_entities_from_llm(llm_design, raw_tables, metadata["tables"])
        edges = [
            (r["from_table"], r["to_table"], f"{r.get('type','1-n')}  {r.get('label','')}")
            for r in llm_design.get("relationships", [])
        ]
        domains = llm_design.get("domains", [])
        positions = layout_cdm_grid(entities)
        zone_cells = compute_zone_cells_from_positions(entities, positions, domains)
        diagram = build_drawio_page("CDM", entities, edges, metadata,
                                    layout="cdm", zone_cells=zone_cells,
                                    cdm_positions=positions)
        xml = '<mxfile host="app.diagrams.net" pages="1">' + diagram + "</mxfile>"
        (OUTPUT_DIR / "cdm.drawio").write_text(xml, encoding="utf-8")
        return

    # === FALLBACK: hiển thị tất cả entities theo domain, không cần API key ===
    print("[CDM] No API key or LLM error — using rule-based fallback (all entities)")
    all_entities_map = {e["base_table"]: e for e in metadata["entities"]}
    entity_bases = set(all_entities_map.keys())
    s2b = metadata.get("_suffix_to_base", {})

    # Sắp xếp entities theo domain để layout_cdm_grid nhóm đẹp
    from collections import Counter
    domain_order_priority = [
        "Institution & Organization", "Learning & Study",
        "Credential & Certificate", "Learner Profile",
        "Reward & Discipline", "Staff & Lecturer", "Reference / Other",
    ]

    def entity_domain_key(e):
        d = e.get("domain", "Reference / Other")
        try:
            return domain_order_priority.index(d)
        except ValueError:
            return len(domain_order_priority)

    entities = sorted(
        [e for e in all_entities_map.values() if not _is_garbage_table(e["base_table"])],
        key=lambda e: (entity_domain_key(e), e["base_table"])
    )
    print(f"[CDM] Fallback showing {len(entities)} entities")

    def resolve_entity(raw):
        if raw in entity_bases:
            return raw
        return s2b.get(raw, raw)

    seen = set()
    edges = []
    for r in metadata["relationships"]:
        f = resolve_entity(r["from_table"])
        t = resolve_entity(r["to_table"])
        if f == t or f not in entity_bases or t not in entity_bases:
            continue
        if (f, t) not in seen:
            seen.add((f, t))
            edges.append((f, t, "1-n"))

    positions = layout_cdm_grid(entities)
    domains_def = [
        {"name": d, "fill_color": c, "stroke_color": s}
        for d, c, s in [
            ("Institution & Organization", "#dae8fc", "#6c8ebf"),
            ("Learner Profile",            "#d5e8d4", "#82b366"),
            ("Learning & Study",           "#d5e8d4", "#82b366"),
            ("Credential & Certificate",   "#fff2cc", "#d6b656"),
            ("Reward & Discipline",        "#ffe6cc", "#d79b00"),
            ("Staff & Lecturer",           "#e1d5e7", "#9673a6"),
            ("Reference / Other",          "#f5f5f5", "#666666"),
        ]
    ]
    zone_cells = compute_zone_cells_from_positions(entities, positions, domains_def)
    diagram = build_drawio_page("CDM", entities, edges, metadata,
                                layout="cdm", zone_cells=zone_cells,
                                cdm_positions=positions)
    xml = '<mxfile host="app.diagrams.net" pages="1">' + diagram + "</mxfile>"
    (OUTPUT_DIR / "cdm.drawio").write_text(xml, encoding="utf-8")


def domain_background_cells():
    """Colored zone rectangles rendered behind entity tables for domain grouping."""
    style = (
        "rounded=1;whiteSpace=wrap;html=1;verticalAlign=top;align=center;"
        "fontSize=11;fontStyle=1;opacity=40;strokeWidth=1.5;spacingTop=4;"
    )
    # (label, fillColor, strokeColor, x, y, w, h)
    zones = [
        ("Cơ sở giáo dục đại học",            "#d5e8d4", "#82b366",  45,  895,  415, 290),
        ("Cơ sở vật chất & Chương trình ĐT",  "#dae8fc", "#6c8ebf", 560,   45,  445, 2005),
        ("Học viên",                           "#ffe6cc", "#d6b656", 1160,  425,  445, 285),
        ("Hoạt động học tập & Văn bằng",       "#ffe6cc", "#d6b656", 1800,   45,  445, 1380),
        ("Cán bộ giảng viên",                  "#e1d5e7", "#9673a6", 1160, 1760,  445, 285),
        ("Công tác & Đào tạo CBGV",            "#e1d5e7", "#9673a6", 1800, 1520,  445, 1010),
    ]
    cells = []
    for i, (label, fill, stroke, x, y, w, h) in enumerate(zones):
        cells.append(
            f'<mxCell id="zone_{i}" value="{html.escape(label)}" '
            f'style="{style}fillColor={fill};strokeColor={stroke};" '
            f'vertex="1" parent="1">'
            f'<mxGeometry x="{x}" y="{y}" width="{w}" height="{h}" as="geometry" /></mxCell>'
        )
    return cells


def build_drawio_page(page_name, entities, edges, metadata, layout="two_column", zone_cells=None, cdm_positions=None):
    table_style = (
        "swimlane;fontStyle=0;childLayout=stackLayout;horizontal=1;startSize=32;"
        "horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;"
        "marginBottom=0;whiteSpace=wrap;html=1;fillColor=#006622;swimlaneFillColor=#f9fff9;"
        "strokeColor=#4a8a4a;fontColor=#ffffff;fontSize=12;fontStyle=1;"
    )
    row_style = (
        "text;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;"
        "spacingLeft=6;spacingRight=4;overflow=hidden;fontSize=11;fontColor=#1a1a1a;"
        "points=[[0,0.5],[1,0.5]];portConstraint=eastwest;rotatable=0;"
    )
    edge_style = (
        "edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;"
        "html=1;fontSize=11;fontStyle=1;labelBackgroundColor=#ffffff;labelBorderColor=none;"
        "endArrow=block;endFill=1;strokeColor=#2e6b2e;strokeWidth=1.5;"
    )

    cells = ['<mxCell id="0" />', '<mxCell id="1" parent="0" />']
    if zone_cells:
        cells.extend(zone_cells)
    width = 360
    row_height = 26
    if layout == "cdm" and cdm_positions:
        positions = cdm_positions
    elif layout == "single":
        positions = layout_single_page_entities([entity["base_table"] for entity in entities])
    else:
        positions = layout_page_entities([entity["base_table"] for entity in entities])
    node_geometry = {}
    id_by_base = {}

    for index, entity in enumerate(entities, start=2):
        entity_id = f"e{index}"
        id_by_base[entity["base_table"]] = entity_id
        x, y = positions[entity["base_table"]]
        columns = select_identity_columns(entity, metadata)
        height = 30 + len(columns) * row_height
        cells.append(
            f'<mxCell id="{entity_id}" value="{html.escape(entity["base_table"])}" style="{table_style}" vertex="1" parent="1">'
            f'<mxGeometry x="{x}" y="{y}" width="{width}" height="{height}" as="geometry" /></mxCell>'
        )
        node_geometry[entity_id] = (x, y, width, height)
        for col_index, column in enumerate(columns, start=1):
            key = f" ({column['key']})" if column.get("key") else ""
            value = html.escape(f"{column['name']}{key}")
            cells.append(
                f'<mxCell id="{entity_id}_c{col_index}" value="{value}" style="{row_style}" vertex="1" parent="{entity_id}">'
                f'<mxGeometry y="{col_index * row_height}" width="{width}" height="{row_height}" as="geometry" /></mxCell>'
            )

    lane_counts = defaultdict(int)
    source_counts = defaultdict(int)
    target_counts = defaultdict(int)
    for edge_index, (source_base, target_base, cardinality) in enumerate(edges, start=1000):
        if source_base not in id_by_base or target_base not in id_by_base:
            continue
        source_id = id_by_base[source_base]
        target_id = id_by_base[target_base]
        if layout == "cdm":
            # CDM layout: auto-route, draw.io tự chọn đường đẹp nhất
            cells.append(
                f'<mxCell id="r{edge_index}" value="{html.escape(cardinality)}" '
                f'style="{edge_style}" edge="1" parent="1" '
                f'source="{source_id}" target="{target_id}">'
                '<mxGeometry relative="1" as="geometry" /></mxCell>'
            )
        else:
            lane_key = edge_lane_key(source_id, target_id, node_geometry)
            lane_index = lane_counts[lane_key]
            lane_counts[lane_key] += 1
            source_slot = source_counts[source_id]
            target_slot = target_counts[target_id]
            source_counts[source_id] += 1
            target_counts[target_id] += 1
            cells.append(
                drawio_edge_cell(
                    f"r{edge_index}",
                    cardinality,
                    edge_style,
                    source_id,
                    target_id,
                    node_geometry,
                    lane_index,
                    source_slot,
                    target_slot,
                )
            )

    return (
        f'<diagram name="{html.escape(page_name)}">'
        '<mxGraphModel grid="1" page="1" gridSize="10" guides="1" tooltips="1" connect="1" '
        'arrows="1" fold="1" pageScale="1" pageWidth="2700" pageHeight="2800" math="0" shadow="0"><root>'
        + "".join(cells)
        + "</root></mxGraphModel></diagram>"
    )


def layout_page_entities(base_tables):
    if not base_tables:
        return {}
    positions = {}
    root = base_tables[0]
    right_tables = base_tables[1:]
    y_values = [60 + index * 185 for index in range(max(len(right_tables), 1))]
    root_y = y_values[len(y_values) // 2] if y_values else 520
    positions[root] = (80, root_y)
    for index, table in enumerate(right_tables):
        x = 620
        y = y_values[index]
        positions[table] = (x, y)
    return positions


def layout_single_page_entities(base_tables):
    # 4-column layout: C1=80, C2=600, C3=1200, C4=1840 (table width=360)
    # C1 hub centered at midpoint of C2 children (y=80..1780 → mid≈930)
    positions = {
        "cosogiaoducdaihoc":                              (80,   930),
        "thongtincocautochuc":                            (600,   80),
        "thongtintoanha":                                 (600,  420),
        "csvcvatrangthietbidatdai":                       (600,  760),
        "phonghocgiangduongvahoitruong":                  (600, 1100),
        "DanhSachNganhDaoTao":                            (600, 1440),
        "ChuongTrinhDaoTao":                              (600, 1780),
        "ttchunghocvien":                                 (1200,  460),
        "thongtinhoctapsvdh":                             (1840,   80),
        "VanBangChungChi":                                (1840,  420),
        "KhenThuong":                                     (1840,  760),
        "KyLuat":                                         (1840, 1100),
        "ThongTinCanBoGiangVien":                         (1200, 1800),
        "PhongBanDonViCongTac":                           (1840, 1560),
        "QuaTrinhCongTacCuaCanBoGiangVien":               (1840, 1900),
        "QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien":        (1840, 2240),
    }
    fallback_x, fallback_y = 80, 2660
    result = {}
    for i, table in enumerate(base_tables):
        if table in positions:
            result[table] = positions[table]
        else:
            result[table] = (fallback_x, fallback_y)
            fallback_x += 460
            if fallback_x > 1840:
                fallback_x = 80
                fallback_y += 340
    return result


def edge_lane_key(source_id, target_id, node_geometry):
    # Corridor thresholds match column layout: C1(80-440), C2(600-960), C3(1200-1560), C4(1840-2200)
    sx, _sy, sw, _sh = node_geometry[source_id]
    tx, _ty, tw, _th = node_geometry[target_id]
    sc = sx + sw / 2
    tc = tx + tw / 2
    left = min(sc, tc)
    right = max(sc, tc)
    if right <= 990:
        return "gap_c1_c2"
    if left >= 950 and right <= 1590:
        return "gap_c2_c3"
    if left >= 1550:
        return "gap_c3_c4"
    return f"free_{int(left)}_{int(right)}"


def drawio_edge_cell(
    edge_id,
    value,
    style,
    source_id,
    target_id,
    node_geometry,
    lane_index=0,
    source_slot=0,
    target_slot=0,
):
    # Column layout: C1(80-440), C2(600-960), C3(1200-1560), C4(1840-2200)
    # Corridors: C1-C2 base=462 step=22, C2-C3 base=982 step=38, C3-C4 base=1582 step=38
    sx, sy, sw, sh = node_geometry[source_id]
    tx, ty, tw, th = node_geometry[target_id]
    if value.startswith("n-n"):
        return drawio_outer_edge_cell(edge_id, value, style, source_id, target_id, node_geometry, lane_index, source_slot, target_slot)
    exit_y = edge_anchor_ratio(source_slot)
    entry_y = edge_anchor_ratio(target_slot)
    source_y = sy + sh * exit_y
    target_y = ty + th * entry_y

    if sx < 500 and tx >= 1200 and tx < 1840:
        # C1 → C3: arch ABOVE the diagram (route_y negative, clear of all tables)
        route_y = -60 - lane_index * 40
        sc_x = sx + sw / 2   # exit from hub top-center
        tc_x = tx + tw / 2   # enter target top-center
        anchor = "exitX=0.5;exitY=0;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;"
        return (
            f'<mxCell id="{edge_id}" value="{html.escape(value)}" style="{style}{anchor}" edge="1" parent="1" '
            f'source="{source_id}" target="{target_id}">'
            '<mxGeometry relative="1" as="geometry"><Array as="points">'
            f'<mxPoint x="{sc_x}" y="{route_y}" />'
            f'<mxPoint x="{tc_x}" y="{route_y}" />'
            '</Array></mxGeometry></mxCell>'
        )

    if sx < 500 and tx >= 600 and tx < 1200:
        # C1 → C2 corridor
        route_x = 462 + lane_index * 22
        anchor = f"exitX=1;exitY={exit_y};exitDx=0;exitDy=0;entryX=0;entryY={entry_y};entryDx=0;entryDy=0;"
    elif sx >= 600 and sx < 1200 and tx >= 1200:
        # C2 → C3 corridor
        route_x = 982 + lane_index * 38
        anchor = f"exitX=1;exitY={exit_y};exitDx=0;exitDy=0;entryX=0;entryY={entry_y};entryDx=0;entryDy=0;"
    elif sx >= 1200 and sx < 1840 and tx >= 600 and tx < 1200:
        # C3 → C2 corridor (reversed)
        route_x = 982 + lane_index * 38
        anchor = f"exitX=0;exitY={exit_y};exitDx=0;exitDy=0;entryX=1;entryY={entry_y};entryDx=0;entryDy=0;"
    elif sx >= 1200 and sx < 1840 and tx >= 1840:
        # C3 → C4 corridor
        route_x = 1582 + lane_index * 38
        anchor = f"exitX=1;exitY={exit_y};exitDx=0;exitDy=0;entryX=0;entryY={entry_y};entryDx=0;entryDy=0;"
    elif sx >= 1840 and tx >= 1200 and tx < 1840:
        # C4 → C3 corridor (reversed)
        route_x = 1582 + lane_index * 38
        anchor = f"exitX=0;exitY={exit_y};exitDx=0;exitDy=0;entryX=1;entryY={entry_y};entryDx=0;entryDy=0;"
    elif sx + sw <= tx:
        route_x = sx + sw + max(40, (tx - sx - sw) // 2) + lane_index * 30
        anchor = f"exitX=1;exitY={exit_y};exitDx=0;exitDy=0;entryX=0;entryY={entry_y};entryDx=0;entryDy=0;"
    elif tx + tw <= sx:
        route_x = tx + tw + max(40, (sx - tx - tw) // 2) + lane_index * 30
        anchor = f"exitX=0;exitY={exit_y};exitDx=0;exitDy=0;entryX=1;entryY={entry_y};entryDx=0;entryDy=0;"
    else:
        route_x = max(sx + sw, tx + tw) + 60 + lane_index * 30
        anchor = f"exitX=1;exitY={exit_y};exitDx=0;exitDy=0;entryX=1;entryY={entry_y};entryDx=0;entryDy=0;"

    return (
        f'<mxCell id="{edge_id}" value="{html.escape(value)}" style="{style}{anchor}" edge="1" parent="1" '
        f'source="{source_id}" target="{target_id}">'
        '<mxGeometry relative="1" as="geometry">'
        '<Array as="points">'
        f'<mxPoint x="{route_x}" y="{source_y}" />'
        f'<mxPoint x="{route_x}" y="{target_y}" />'
        '</Array>'
        '</mxGeometry></mxCell>'
    )


def drawio_outer_edge_cell(edge_id, value, style, source_id, target_id, node_geometry, lane_index=0, source_slot=0, target_slot=0):
    # n-n (và n-n: label) edges giữa C3 và C2: route qua corridor C2-C3 (x=1060+40*lane)
    sx, sy, sw, sh = node_geometry[source_id]
    tx, ty, tw, th = node_geometry[target_id]
    exit_y = edge_anchor_ratio(source_slot)
    entry_y = edge_anchor_ratio(target_slot)
    source_y = sy + sh * exit_y
    target_y = ty + th * entry_y

    in_c3 = lambda x: 1150 <= x < 1850
    in_c2 = lambda x: 550 <= x < 1000

    if in_c3(sx) and in_c2(tx):
        # C3 exits LEFT, C2 enters RIGHT — route through C2-C3 corridor
        route_x = 1060 + lane_index * 40
        anchor = f"exitX=0;exitY={exit_y};exitDx=0;exitDy=0;entryX=1;entryY={entry_y};entryDx=0;entryDy=0;"
    elif in_c2(sx) and in_c3(tx):
        # C2 exits RIGHT, C3 enters LEFT
        route_x = 1060 + lane_index * 40
        anchor = f"exitX=1;exitY={exit_y};exitDx=0;exitDy=0;entryX=0;entryY={entry_y};entryDx=0;entryDy=0;"
    else:
        # Fallback: route below the bottom of both nodes
        route_y = max(sy + sh, ty + th) + 120 + lane_index * 40
        return (
            f'<mxCell id="{edge_id}" value="{html.escape(value)}" style="{style}'
            f'exitX=1;exitY={exit_y};exitDx=0;exitDy=0;entryX=0;entryY={entry_y};entryDx=0;entryDy=0;" '
            f'edge="1" parent="1" source="{source_id}" target="{target_id}">'
            '<mxGeometry relative="1" as="geometry"><Array as="points">'
            f'<mxPoint x="{sx+sw+60}" y="{source_y}" />'
            f'<mxPoint x="{sx+sw+60}" y="{route_y}" />'
            f'<mxPoint x="{tx-60}" y="{route_y}" />'
            f'<mxPoint x="{tx-60}" y="{target_y}" />'
            '</Array></mxGeometry></mxCell>'
        )

    return (
        f'<mxCell id="{edge_id}" value="{html.escape(value)}" style="{style}{anchor}" edge="1" parent="1" '
        f'source="{source_id}" target="{target_id}">'
        '<mxGeometry relative="1" as="geometry"><Array as="points">'
        f'<mxPoint x="{route_x}" y="{source_y}" />'
        f'<mxPoint x="{route_x}" y="{target_y}" />'
        '</Array></mxGeometry></mxCell>'
    )


def edge_anchor_ratio(slot):
    pattern = [0.18, 0.32, 0.46, 0.60, 0.74, 0.88]
    return pattern[slot % len(pattern)]


def select_identity_columns(entity, metadata):
    table = metadata["tables"].get(entity["base_table"])
    attrs = table["columns"] if table else entity["business_attributes"]
    priority_names = {
        "macosodaotao",
        "mahocvien",
        "macanbo",
        "sodinhdanh",
        "maddtc",
        "manganh",
        "manganhdaotao",
        "machuongtrinhdaotao",
        "maphongban",
        "maphonghocgdht",
        "matoanha",
        "magcn",
        "madinhdanhvbcc",
    }

    def is_surrogate_pk(attr):
        # key<tenbang> là surrogate PK kỹ thuật, không phải business identifier
        return attr["key"] == "PK" and attr["name"].lower().startswith("key")

    def key_score(attr):
        name = attr["name"].lower()
        if is_surrogate_pk(attr):
            return 99   # surrogate PK kỹ thuật — loại bỏ
        if attr["key"] == "FK":
            return 97   # FK = đường quan hệ, không dùng làm identifier
        if attr["key"] == "PK":
            return 0    # business PK
        if name in priority_names:
            return 1    # natural business identifier ưu tiên
        if name.startswith("ma"):
            return 3
        if "so" in name or "id" in name:
            return 4
        return 9

    key_column = None
    for attr in sorted(attrs, key=lambda item: (key_score(item), item["name"])):
        if key_score(attr) < 90:  # bỏ qua surrogate PK (99) và FK (97)
            key_column = attr
            break
    if key_column is None and attrs:
        # fallback: lấy cột đầu tiên không phải surrogate PK
        key_column = next((a for a in attrs if not is_surrogate_pk(a)), attrs[0])

    selected = []
    if key_column is not None:
        selected.append(key_column)

    skip_names = {key_column["name"].lower()} if key_column else set()

    def info_score(attr):
        name = attr["name"].lower()
        if name in skip_names or name in TECHNICAL_COLUMNS:
            return 999
        if is_surrogate_pk(attr):
            return 999  # ẩn surrogate PK — không phải business attribute
        if attr["key"] == "FK":
            return 999  # FK = đường quan hệ trên sơ đồ, không liệt kê như cột
        if name in priority_names:
            return 0
        if name.startswith("ten") or "hoten" in name:
            return 2
        if "email" in name or "diachi" in name or "ngay" in name or "nam" in name:
            return 3
        if name.startswith("ma"):
            return 4
        return 5

    for attr in sorted(attrs, key=lambda item: (info_score(item), item["name"])):
        if len(selected) >= 5:
            break
        if info_score(attr) >= 999:
            continue
        selected.append({**attr, "key": ""})

    if len(attrs) > len(selected):
        selected.append({"name": "...", "key": "", "type": "", "description": "", "source_table": entity["base_table"]})
    return selected


def infer_cardinality(rel, metadata):
    from_role = metadata["tables"].get(rel["from_table"], {}).get("role", "")
    if "subtype" in from_role:
        return "1-1"
    if rel["type"] == "inferred-business-key" and rel["from_column"] == "mahocvien":
        return "1-n"
    if rel["from_column"] == "macosodaotao":
        return "1-n"
    return "1-n"


def should_draw_relationship(rel, source_entity, target_entity):
    if source_entity == "Higher Education Institution" and rel["from_column"] == "macosodaotao":
        direct_children = {
            "Organization Unit",
            "Building",
            "Land / Facility Asset",
            "Teaching Room / Hall",
            "Training Major",
            "Training Program",
        }
        return target_entity in direct_children
    return True


def inferred_summary_edges(entity_positions):
    edges = []
    if "Learner" in entity_positions and "Training Program" in entity_positions:
        edges.append(("Learner", "Training Program", "n-n", "via Study Record"))
    if "Staff / Lecturer" in entity_positions and "Organization Unit" in entity_positions:
        edges.append(("Staff / Lecturer", "Organization Unit", "n-n", "via Assignment"))
    if "Learner" in entity_positions and "Postgraduate Study Record" in entity_positions:
        edges.append(("Learner", "Postgraduate Study Record", "1-n", "has"))
    if "Learner" in entity_positions and "Credential / Certificate" in entity_positions:
        edges.append(("Learner", "Credential / Certificate", "1-n", "earns"))
    if "Learner" in entity_positions and "Reward" in entity_positions:
        edges.append(("Learner", "Reward", "1-n", "receives"))
    if "Learner" in entity_positions and "Discipline" in entity_positions:
        edges.append(("Learner", "Discipline", "1-n", "subject_to"))
    if "Staff / Lecturer" in entity_positions and "Work Unit Assignment" in entity_positions:
        edges.append(("Staff / Lecturer", "Work Unit Assignment", "1-n", "assigned_to"))
    if "Staff / Lecturer" in entity_positions and "Teaching / Work History" in entity_positions:
        edges.append(("Staff / Lecturer", "Teaching / Work History", "1-n", "has"))
    if "Staff / Lecturer" in entity_positions and "Staff Education / Training History" in entity_positions:
        edges.append(("Staff / Lecturer", "Staff Education / Training History", "1-n", "has"))
    return edges


def main():
    workbook = sys.argv[1] if len(sys.argv) > 1 else None
    OUTPUT_DIR.mkdir(exist_ok=True)
    metadata = build_metadata(workbook)
    write_pipeline_overview(metadata)
    write_json(metadata)
    write_table_classifier(metadata)
    write_business_entity_groups(metadata)
    write_relationship_simplification(metadata)
    write_domain_map(metadata)
    write_glossary(metadata)
    write_cdm(metadata)
    write_mermaid(metadata)
    write_drawio(metadata)
    write_drawio_dbeaver_style(metadata)
    write_reviewer_approval(metadata)
    print(f"Wrote CDM outputs to {OUTPUT_DIR.resolve()}")
    print(f"Entities: {len(metadata['entities'])}")
    print(f"Relationships: {len(metadata['relationships'])}")


if __name__ == "__main__":
    main()
