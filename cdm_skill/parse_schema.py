"""
parse_schema.py — Buoc 1 cua skill CDM (v2).

Doc file Excel Book-style (table_name | column_name | data_type | length |
not_null | key | description) va xuat JSON tom tat cho LLM doc.

Quy tac xu ly bang con (suffix) — theo template Logical:
  - Bien the 1-1 (_nguoivn, _congdannuocngoai)      -> GOP thanh dong trong box cha
  - Bang con 1-1 (_thongtincha, _thongtinme, ...)   -> box RIENG, quan he 1-1
  - Bang con 1-n (_ds*, _diemmon, _giaytodinhdanh,  -> box RIENG, quan he 1-n
    _monhoc, _khenthuong, _kyluat, _bangdiem, ...)

Usage:
    python parse_schema.py <book.xlsx> [-o schema_summary.json]
"""
import argparse
import json
import re
import sys
from collections import OrderedDict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from generate_book1_schema import load_tables, uniquify_columns  # noqa: E402


# Bien the quoc tich (1-1) -> gop thanh dong trong box cha
NAT_EXACT = ("nguoivn", "congdannuocngoai", "cogndannuocngoai")
# Prefix quoc tich long nhau -> strip de lay phan y nghia (vd nguoivn_giaytodinhdanhcn)
NAT_PREFIXES = ("nguoivn_", "congdannuocngoai_", "cogndannuocngoai_")

# Suffix box rieng quan he 1-1
SEPARATE_1_1_TOKENS = ("thongtincha", "thongtinme", "thongtinhieuchinh",
                       "quyetdinhthoihocbaoluu")

# Con lai (co suffix) mac dinh box rieng quan he 1-n
# (vd: _giaytodinhdanh*, _ds*, _diemmon, _monday, _monkiemnhiem, _ngoaingu,
#  _monhoc, _khenthuong, _kyluat, _nguoidodau, _quatrinhhoctap, _bangdiem, _chungchi)

TECHNICAL_COLUMNS = {
    "idbanghi", "sukien", "phienban", "thoigiancapnhat", "ngaycapnhat",
}


def is_garbage_table(name: str) -> bool:
    low = name.lower()
    if low.startswith(("decimal", "numeric", "varchar", "char", "int", "bigint")):
        return True
    if re.match(r"^[\d,.\(\)_\s]+$", name):
        return True
    return False


def col_brief(c):
    e = {"name": c.name, "type": c.col_type, "key": c.key or ""}
    if c.description:
        e["desc"] = c.description.split("\n")[0][:80]
    return e


def key_columns(cols):
    """Lay cot khoa de hien trong box: PK + ma* + vai attr (bo cot ky thuat)."""
    pk   = [col_brief(c) for c in cols if c.key == "PK" and not c.name.lower().startswith("key")]
    code = [col_brief(c) for c in cols if c.key not in ("PK", "FK")
            and c.name.lower().startswith("ma")][:6]
    attr = [col_brief(c) for c in cols if c.key not in ("PK", "FK")
            and not c.name.lower().startswith("ma")
            and c.name.lower() not in TECHNICAL_COLUMNS][:5]
    return pk, code, attr


def child_label(base: str, child: str) -> str:
    """Lay phan suffix lam ten box con (bo prefix base + '_')."""
    if child.lower().startswith(base.lower() + "_"):
        return child[len(base) + 1:]
    return child


def clean_child_label(label: str):
    """Strip prefix quoc tich; tra ve (label_sach, la_bien_the_quoctich_thuan)."""
    low = label.lower()
    if low in NAT_EXACT:
        return label, True                 # bien the quoc tich thuan -> merge
    for p in NAT_PREFIXES:
        if low.startswith(p):
            return label[len(p):], False   # vd nguoivn_giaytodinhdanhcn -> giaytodinhdanhcn
    return label, False


def classify_child(clean_lower: str) -> str:
    """Tra ve '1-1' | '1-n' dua tren token suffix (sau khi da strip quoc tich)."""
    for tok in SEPARATE_1_1_TOKENS:
        if tok in clean_lower:
            return "1-1"
    return "1-n"


def summarize(workbook: str) -> dict:
    tables, _ = load_tables(workbook)
    names = [n for n in tables if not is_garbage_table(n)]

    # Tim base cho moi bang: base dai nhat ma 'name' = base + '_...'
    def parent_of(name):
        best = None
        for other in names:
            if other != name and name.lower().startswith(other.lower() + "_"):
                if best is None or len(other) > len(best):
                    best = other
        return best

    parent = {n: parent_of(n) for n in names}
    base_tables = [n for n in names if parent[n] is None]

    # Gom con theo base goc (transitive: lan len toi base khong co cha)
    def root_of(name):
        cur = name
        seen = set()
        while parent.get(cur) and cur not in seen:
            seen.add(cur)
            cur = parent[cur]
        return cur

    children_of = {b: [] for b in base_tables}
    for n in names:
        if parent[n] is not None:
            children_of[root_of(n)].append(n)

    entities = []
    for base in base_tables:
        cols = uniquify_columns(tables[base])
        pk, code, attr = key_columns(cols)
        merged_rows = []         # bien the 1-1 gop thanh dong
        child_entities = []      # box rieng

        for child in children_of[base]:
            raw_label = child_label(base, child)
            clean, is_nat_variant = clean_child_label(raw_label)
            ccols = uniquify_columns(tables[child])
            if is_nat_variant:
                merged_rows.append(raw_label)        # bien the quoc tich -> dong phu
                continue
            kind = classify_child(clean.lower())
            cpk, ccode, cattr = key_columns(ccols)
            child_entities.append({
                "table": child,
                "label": clean,                       # ten sach (da bo prefix quoc tich)
                "cardinality": kind,                  # '1-1' hoac '1-n'
                "pk": cpk, "codes": ccode, "attrs": cattr,
                "n_columns": len(ccols),
            })

        entities.append({
            "base_table": base,
            "pk": pk, "codes": code, "attrs": attr,
            "merged_variants": merged_rows,        # hien thi nhu dong phu
            "child_entities": child_entities,      # box rieng + quan he
            "n_columns": len(cols),
        })

    return {
        "source": Path(workbook).name,
        "n_base_entities": len(entities),
        "n_child_entities": sum(len(e["child_entities"]) for e in entities),
        "n_physical_tables": len(tables),
        "dropped_garbage": [t for t in tables if is_garbage_table(t)],
        "entities": entities,
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("workbook")
    ap.add_argument("-o", "--output", default="schema_summary.json")
    args = ap.parse_args()

    s = summarize(args.workbook)
    Path(args.output).write_text(json.dumps(s, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"OK: {s['n_base_entities']} entity goc + {s['n_child_entities']} entity con "
          f"tu {s['n_physical_tables']} bang vat ly")
    print(f"Da ghi: {Path(args.output).resolve()}")
    for e in s["entities"]:
        codes = ",".join(c["name"] for c in e["codes"])
        mv = f" +{len(e['merged_variants'])}row" if e["merged_variants"] else ""
        ch = f" -> {len(e['child_entities'])} con" if e["child_entities"] else ""
        print(f"  - {e['base_table']} (codes=[{codes}]){mv}{ch}")
        for c in e["child_entities"]:
            print(f"       |- {c['label']} [{c['cardinality']}]")


if __name__ == "__main__":
    main()
