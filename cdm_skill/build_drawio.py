"""
build_drawio.py — Buoc 3 cua skill CDM.

Nhan 1 file design JSON (do LLM/Claude thiet ke) va sinh file .drawio TRUC QUAN:
  - Layered domain layout: moi domain la 1 zone, cac zone xep luoi, KHONG chong box.
  - Crow's foot ER notation cho cardinality 1-1 / 1-n / n-n.
  - Edge dung orthogonalEdgeStyle, KHONG waypoint thu cong -> draw.io tu route,
    tranh duong chong len nhau.

Design JSON:
{
  "title": "CDM ...",
  "entities": [
    {"display_name":"Hoc sinh", "base_table":"thongtinhocsinh...",
     "domain":"...", "key_attrs":["mahocsinh (PK)","hoten","ngaysinh"]}
  ],
  "relationships": [
    {"from":"base_table_A", "to":"base_table_B", "type":"1-n", "label":"co"}
  ],
  "domains": [{"name":"...", "fill_color":"#dae8fc", "stroke_color":"#6c8ebf"}]
}

Usage:
    python build_drawio.py design.json -o cdm.drawio [--summary schema_summary.json]
"""
import argparse
import html
import json
import math
from collections import OrderedDict, defaultdict
from pathlib import Path


# ── Kich thuoc & khoang cach (don vi px) ─────────────────────────────────────
ENTITY_W      = 240
ROW_H         = 22          # chieu cao moi dong thuoc tinh
TITLE_H       = 30
ENTITY_VGAP   = 45          # khoang dung giua 2 entity trong cung domain
ZONE_PAD      = 28          # padding zone quanh entities
ZONE_GAP_X    = 130         # khoang ngang giua cac zone (du cho edge chay)
ZONE_GAP_Y    = 110         # khoang dung giua cac hang zone
ZONE_TITLE_H  = 34          # chua nhan domain o dinh zone
MAX_ATTRS     = 6


# ── Crow's foot ER cardinality ───────────────────────────────────────────────
def er_arrows(rel_type: str) -> str:
    """Tra ve style endArrow/startArrow theo notation chan chim (crow's foot)."""
    t = (rel_type or "1-n").lower().replace(" ", "")
    if t in ("1-1", "1:1", "one-to-one"):
        return "startArrow=ERone;startFill=0;endArrow=ERone;endFill=0;"
    if t in ("n-n", "m-n", "n:m", "many-to-many"):
        return "startArrow=ERmany;startFill=0;endArrow=ERmany;endFill=0;"
    # default 1-n
    return "startArrow=ERone;startFill=0;endArrow=ERmany;endFill=0;"


# ── Layout: gom domain, xep entity trong domain, xep zone theo luoi ──────────
def layout(entities, domains):
    # Nhom entity theo domain, giu thu tu domain trong design
    domain_order = [d["name"] for d in domains]
    by_domain = OrderedDict((d, []) for d in domain_order)
    for e in entities:
        by_domain.setdefault(e.get("domain", "Khac"), []).append(e)

    # Kich thuoc moi entity (theo so attrs)
    def ent_h(e):
        n = min(len(e.get("key_attrs", [])), MAX_ATTRS)
        return TITLE_H + max(n, 1) * ROW_H

    # Kich thuoc moi domain-block: 1 cot entity xep doc
    blocks = []  # (domain, entities, block_w, block_h)
    for dom, ents in by_domain.items():
        if not ents:
            continue
        inner_h = sum(ent_h(e) for e in ents) + ENTITY_VGAP * (len(ents) - 1)
        block_w = ENTITY_W + 2 * ZONE_PAD
        block_h = inner_h + 2 * ZONE_PAD + ZONE_TITLE_H
        blocks.append({"domain": dom, "entities": ents, "w": block_w, "h": block_h})

    # Xep cac block theo luoi: n_cols ~ sqrt, can bang chieu cao
    n = len(blocks)
    n_cols = max(1, min(n, round(math.sqrt(n * 1.4))))   # hoi rong de edge thoang
    rows = [blocks[i:i + n_cols] for i in range(0, n, n_cols)]

    positions = {}   # base_table -> (x,y,w,h)
    zones = []       # (domain, x,y,w,h, fill, stroke)
    color_map = {d["name"]: (d.get("fill_color", "#f5f5f5"), d.get("stroke_color", "#999"))
                 for d in domains}

    cur_y = 40
    for row in rows:
        row_h = max(b["h"] for b in row)
        cur_x = 40
        for b in row:
            zx, zy = cur_x, cur_y
            zones.append((b["domain"], zx, zy, b["w"], b["h"],
                          *color_map.get(b["domain"], ("#f5f5f5", "#999999"))))
            # Xep entity trong zone (1 cot, can giua ngang)
            ex = zx + ZONE_PAD
            ey = zy + ZONE_TITLE_H + ZONE_PAD
            for e in b["entities"]:
                h = ent_h(e)
                positions[e["base_table"]] = (ex, ey, ENTITY_W, h)
                ey += h + ENTITY_VGAP
            cur_x += b["w"] + ZONE_GAP_X
        cur_y += row_h + ZONE_GAP_Y

    return positions, zones


# ── Sinh XML draw.io ─────────────────────────────────────────────────────────
def esc(s): return html.escape(str(s))


def build(design):
    entities = design["entities"]
    domains  = design.get("domains", [])
    rels     = design.get("relationships", [])
    title    = design.get("title", "Conceptual Data Model")

    positions, zones = layout(entities, domains)

    zone_style = ("rounded=1;whiteSpace=wrap;html=1;verticalAlign=top;align=center;"
                  "fontSize=13;fontStyle=1;opacity=50;strokeWidth=2;spacingTop=6;arcSize=4;")
    table_style = ("swimlane;fontStyle=1;childLayout=stackLayout;horizontal=1;startSize=30;"
                   "horizontalStack=0;resizeParent=1;resizeParentMax=0;collapsible=0;"
                   "marginBottom=0;whiteSpace=wrap;html=1;fillColor=#ffffff;"
                   "strokeColor=#34495e;fontColor=#1a2530;fontSize=12;")
    row_style = ("text;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;"
                 "spacingLeft=8;spacingRight=4;overflow=hidden;rotatable=0;fontSize=11;"
                 "fontColor=#2c3e50;")
    edge_style = ("edgeStyle=orthogonalEdgeStyle;rounded=1;jettySize=auto;html=1;"
                  "fontSize=11;fontStyle=1;labelBackgroundColor=#ffffff;"
                  "strokeColor=#5a6c7d;strokeWidth=1.5;")

    cells = ['<mxCell id="0" />', '<mxCell id="1" parent="0" />']

    # 1) Zones (ve truoc de nam duoi)
    for i, (dom, x, y, w, h, fill, stroke) in enumerate(zones):
        cells.append(
            f'<mxCell id="zone{i}" value="{esc(dom)}" '
            f'style="{zone_style}fillColor={fill};strokeColor={stroke};" '
            f'vertex="1" parent="1"><mxGeometry x="{x}" y="{y}" width="{w}" height="{h}" '
            f'as="geometry"/></mxCell>'
        )

    # 2) Entities
    id_by_base = {}
    for idx, e in enumerate(entities, start=1):
        base = e["base_table"]
        if base not in positions:
            continue
        x, y, w, h = positions[base]
        eid = f"e{idx}"
        id_by_base[base] = eid
        label = e.get("display_name") or base
        title_val = esc(label)
        if e.get("display_name") and e["display_name"] != base:
            title_val = f'{esc(label)}'
        cells.append(
            f'<mxCell id="{eid}" value="{title_val}" style="{table_style}" '
            f'vertex="1" parent="1"><mxGeometry x="{x}" y="{y}" width="{w}" height="{h}" '
            f'as="geometry"/></mxCell>'
        )
        attrs = e.get("key_attrs", [])[:MAX_ATTRS] or ["(chua co thuoc tinh)"]
        for j, a in enumerate(attrs, start=1):
            cells.append(
                f'<mxCell id="{eid}_a{j}" value="{esc(a)}" style="{row_style}" '
                f'vertex="1" parent="{eid}"><mxGeometry y="{TITLE_H + (j-1)*ROW_H}" '
                f'width="{w}" height="{ROW_H}" as="geometry"/></mxCell>'
            )

    # 3) Edges — chon exit/entry theo huong tuong doi, KHONG waypoint thu cong
    def anchor(src, dst):
        sx, sy, sw, sh = positions[src]
        tx, ty, tw, th = positions[dst]
        scx, scy = sx + sw/2, sy + sh/2
        tcx, tcy = tx + tw/2, ty + th/2
        dx, dy = tcx - scx, tcy - scy
        if abs(dx) >= abs(dy):   # ngang
            if dx >= 0:  return "exitX=1;exitY=0.5;entryX=0;entryY=0.5;"
            else:        return "exitX=0;exitY=0.5;entryX=1;entryY=0.5;"
        else:                    # doc
            if dy >= 0:  return "exitX=0.5;exitY=1;entryX=0.5;entryY=0;"
            else:        return "exitX=0.5;exitY=0;entryX=0.5;entryY=1;"

    for k, r in enumerate(rels, start=1):
        f, t = r.get("from"), r.get("to")
        if f not in id_by_base or t not in id_by_base:
            continue
        card = er_arrows(r.get("type", "1-n"))
        anc = anchor(f, t) + "exitDx=0;exitDy=0;entryDx=0;entryDy=0;"
        label = r.get("label", "")
        cells.append(
            f'<mxCell id="r{k}" value="{esc(label)}" '
            f'style="{edge_style}{card}{anc}" edge="1" parent="1" '
            f'source="{id_by_base[f]}" target="{id_by_base[t]}">'
            f'<mxGeometry relative="1" as="geometry"/></mxCell>'
        )

    # Kich thuoc trang
    max_x = max((x + w for (_, x, y, w, h, *_ ) in zones), default=1200) + 80
    max_y = max((y + h for (_, x, y, w, h, *_ ) in zones), default=900) + 80

    xml = (
        f'<mxfile host="app.diagrams.net"><diagram name="{esc(title)}">'
        f'<mxGraphModel grid="1" gridSize="10" guides="1" tooltips="1" connect="1" '
        f'arrows="1" fold="1" pageScale="1" pageWidth="{int(max_x)}" pageHeight="{int(max_y)}" '
        f'math="0" shadow="0"><root>'
        + "".join(cells) +
        '</root></mxGraphModel></diagram></mxfile>'
    )
    return xml


def attach_attrs_from_summary(design, summary_path):
    """Neu entity chua co key_attrs, lay tu schema_summary.json (PK + codes)."""
    try:
        summary = json.loads(Path(summary_path).read_text(encoding="utf-8"))
    except Exception:
        return design
    by_base = {e["base_table"]: e for e in summary.get("entities", [])}
    for e in design["entities"]:
        if e.get("key_attrs"):
            continue
        s = by_base.get(e["base_table"])
        if not s:
            continue
        ka = [f"{c['name']} (PK)" for c in s.get("pk", [])]
        ka += [c["name"] for c in s.get("codes", [])]
        ka += [c["name"] for c in s.get("attrs", [])]
        e["key_attrs"] = ka[:MAX_ATTRS]
    return design


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("design", help="File design JSON (LLM thiet ke)")
    ap.add_argument("-o", "--output", default="cdm.drawio")
    ap.add_argument("--summary", help="schema_summary.json de lay thuoc tinh neu thieu")
    args = ap.parse_args()

    design = json.loads(Path(args.design).read_text(encoding="utf-8"))
    # Cho phep nhan dinh dang cdm_config.json (entities co 'merged_tables', rel co from_table/to_table)
    design = normalize_design(design)
    if args.summary:
        design = attach_attrs_from_summary(design, args.summary)

    xml = build(design)
    Path(args.output).write_text(xml, encoding="utf-8")
    n_e = len(design["entities"])
    n_r = len([r for r in design.get("relationships", [])])
    print(f"OK: {n_e} entities, {n_r} relationships -> {Path(args.output).resolve()}")


def normalize_design(design):
    """Chap nhan ca format cdm_config.json (from_table/to_table) lan format design (from/to)."""
    ents = []
    for e in design.get("entities", []):
        ents.append({
            "display_name": e.get("display_name") or e.get("base_table"),
            "base_table": e["base_table"],
            "domain": e.get("domain", "Khac"),
            "key_attrs": e.get("key_attrs", []),
        })
    rels = []
    for r in design.get("relationships", []):
        rels.append({
            "from": r.get("from") or r.get("from_table"),
            "to":   r.get("to") or r.get("to_table"),
            "type": r.get("type", "1-n"),
            "label": r.get("label", ""),
        })
    return {
        "title": design.get("title", "Conceptual Data Model"),
        "entities": ents,
        "relationships": rels,
        "domains": design.get("domains", []),
    }


if __name__ == "__main__":
    main()
