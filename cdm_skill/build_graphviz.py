"""
build_graphviz.py — Sinh drawio theo TEMPLATE (v2), Graphviz lam layout.

Theo file mau nguoi dung cung cap:
  - Cardinality bang NHAN CHU "1"/"n" (edgeLabel), khong crow's foot.
  - Entity LOI (base table) to GREEN; entity CON (bang con tach ra) to TRANG.
  - Bang con 1-n / 1-1 -> box rieng, noi voi cha bang quan he co cardinality.
  - Bien the quoc tich (_NguoiVN, _CongDanNuocNgoai) -> dong phu trong box cha.
  - Domain -> zone mau (ket hop voi entity loi noi bat).
Graphviz (dot) lo: vi tri + dinh tuyen edge tranh bang (splines=ortho).

Input:
  design.json        (top-level entities: domain + quan he nghiep vu cross-entity)
  schema_summary.json (child_entities + merged_variants moi base)

Usage:
  python build_graphviz.py design.json --summary schema_summary.json -o cdm.drawio [--rankdir TB]
"""
import argparse
import html
import json
import re
import shutil
import subprocess
from collections import defaultdict
from pathlib import Path

ENTITY_W = 230
ROW_H    = 26
TITLE_H  = 30
DPI      = 72.0
MAX_ATTRS = 7   # co the override bang --max-attrs

CORE_FILL, CORE_FONT, CORE_STROKE = "#008a00", "#ffffff", "#005700"
CHILD_FILL, CHILD_FONT, CHILD_STROKE = "#ffffff", "#1a2530", "#7a7a7a"


def esc(s): return html.escape(str(s))


def find_dot():
    for c in (shutil.which("dot"),
              r"C:\Program Files\Graphviz\bin\dot.exe",
              r"C:\Program Files (x86)\Graphviz\bin\dot.exe"):
        if c and Path(c).exists():
            return c
    return None


def gv_id(key):
    return "n_" + re.sub(r"[^A-Za-z0-9_]", "_", key)


def card_pair(rel_type: str):
    """('1','n') tu type '1-n'. Parent=trai, child=phai."""
    t = (rel_type or "1-n").lower().replace(" ", "")
    m = {"1-1": ("1", "1"), "1-n": ("1", "n"), "n-1": ("n", "1"),
         "n-n": ("n", "n"), "m-n": ("n", "n")}
    return m.get(t, ("1", "n"))


# ── Hop nhat design + summary thanh danh sach entity/edge thong nhat ──────────
def assemble(design, summary):
    by_base = {e["base_table"]: e for e in summary.get("entities", [])}
    domain_of = {e["base_table"]: e.get("domain", "Khac") for e in design["entities"]}
    color_map = {d["name"]: (d.get("fill_color", "#f5f5f5"), d.get("stroke_color", "#999999"))
                 for d in design.get("domains", [])}

    entities = {}   # id -> {label, domain, core, attrs}
    edges = []      # {src, tgt, type}

    # 1) Entity loi (top-level)
    for e in design["entities"]:
        base = e["base_table"]
        s = by_base.get(base, {})
        attrs = [f"{c['name']} (PK)" for c in s.get("pk", [])]
        attrs += [c["name"] for c in s.get("codes", [])]
        attrs += [c["name"] for c in s.get("attrs", [])]
        # them dong phu bien the quoc tich
        for v in s.get("merged_variants", []):
            attrs.append(f"[{v}]")
        entities[gv_id(base)] = {
            "label": e.get("display_name") or base,
            "domain": e.get("domain", "Khac"),
            "core": True,
            "attrs": attrs[:MAX_ATTRS],
        }
        # 2) Entity con + quan he cha-con
        for ch in s.get("child_entities", []):
            cid = gv_id(base + "__" + ch["table"])
            cattrs = [f"{c['name']} (PK)" for c in ch.get("pk", [])]
            cattrs += [c["name"] for c in ch.get("codes", [])]
            cattrs += [c["name"] for c in ch.get("attrs", [])]
            entities[cid] = {
                "label": ch["label"],
                "domain": e.get("domain", "Khac"),
                "core": False,
                "attrs": cattrs[:MAX_ATTRS] or ["..."],
            }
            edges.append({"src": gv_id(base), "tgt": cid, "type": ch["cardinality"]})

    # 3) Quan he nghiep vu cross-entity (tu design)
    for r in design.get("relationships", []):
        s_id, t_id = gv_id(r.get("from") or r.get("from_table")), gv_id(r.get("to") or r.get("to_table"))
        if s_id in entities and t_id in entities:
            edges.append({"src": s_id, "tgt": t_id, "type": r.get("type", "1-n"),
                          "label": r.get("label", "")})

    return entities, edges, color_map


def ent_h(e):
    return TITLE_H + max(min(len(e["attrs"]), MAX_ATTRS), 1) * ROW_H


def build_dot(entities, edges, color_map, rankdir="TB"):
    by_domain = defaultdict(list)
    for eid, e in entities.items():
        by_domain[e["domain"]].append(eid)

    lines = [
        "digraph CDM {",
        f'  graph [rankdir={rankdir}, splines=ortho, nodesep=0.55, ranksep=1.2, '
        'pad=0.4, compound=true, overlap=false, fontname="Segoe UI"];',
        '  node [shape=box, fixedsize=true, fontname="Segoe UI", fontsize=12];',
        '  edge [fontname="Segoe UI", fontsize=11];',
    ]
    for ci, (dom, ids) in enumerate(by_domain.items()):
        fill, stroke = color_map.get(dom, ("#f5f5f5", "#999999"))
        lines.append(f'  subgraph cluster_{ci} {{')
        lines.append(f'    label="{dom}"; style="rounded,filled"; fillcolor="{fill}55"; '
                     f'color="{stroke}"; fontsize=15; fontname="Segoe UI";')
        for eid in ids:
            e = entities[eid]
            lines.append(f'    {eid} [label="{e["label"]}", '
                         f'width={ENTITY_W/DPI:.3f}, height={ent_h(e)/DPI:.3f}];')
        lines.append("  }")
    for ed in edges:
        lines.append(f'  {ed["src"]} -> {ed["tgt"]};')
    lines.append("}")
    return "\n".join(lines)


def run_dot(dot_path, src):
    p = subprocess.run([dot_path, "-Tjson"], input=src, capture_output=True,
                       text=True, encoding="utf-8")
    if p.returncode != 0:
        raise RuntimeError(f"dot loi: {p.stderr[:400]}")
    return json.loads(p.stdout)


def parse_gv(gv):
    bb = [float(v) for v in gv["bb"].split(",")]
    H = bb[3]
    def flip(y): return H - y
    id2name, nodes, clusters = {}, {}, []
    for o in gv.get("objects", []):
        name = o.get("name", "")
        id2name[o.get("_gvid")] = name
        if name.startswith("cluster"):
            if "bb" in o:
                llx, lly, urx, ury = [float(v) for v in o["bb"].split(",")]
                clusters.append((o.get("label", ""), llx, flip(ury), urx - llx, ury - lly))
            continue
        if "pos" not in o:
            continue
        cx, cy = [float(v) for v in o["pos"].split(",")]
        w = float(o.get("width", 1)) * DPI
        h = float(o.get("height", 1)) * DPI
        nodes[name] = (cx - w/2, flip(cy) - h/2, w, h)
    edges = []
    for ed in gv.get("edges", []):
        pts = []
        for d in ed.get("_draw_", []):
            if d.get("op") in ("b", "B", "L", "p", "P") and "points" in d:
                pts = [(float(px), flip(float(py))) for px, py in d["points"]]
                break
        edges.append({"tail": id2name.get(ed.get("tail")),
                      "head": id2name.get(ed.get("head")), "points": pts})
    return nodes, clusters


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("design")
    ap.add_argument("--summary", required=True)
    ap.add_argument("-o", "--output", default="cdm.drawio")
    ap.add_argument("--rankdir", default="TB", choices=["TB", "LR"])
    ap.add_argument("--max-attrs", type=int, default=None, help="Gioi han so dong thuoc tinh (0 = chi tieu de)")
    ap.add_argument("--dot")
    ap.add_argument("--keep-dot", action="store_true")
    args = ap.parse_args()

    global MAX_ATTRS
    if args.max_attrs is not None:
        MAX_ATTRS = args.max_attrs

    dot_path = args.dot or find_dot()
    if not dot_path:
        raise SystemExit("Khong tim thay dot.exe — cai Graphviz.")

    design = json.loads(Path(args.design).read_text(encoding="utf-8"))
    summary = json.loads(Path(args.summary).read_text(encoding="utf-8"))
    entities, edges, color_map = assemble(design, summary)

    dot_src = build_dot(entities, edges, color_map, rankdir=args.rankdir)
    if args.keep_dot:
        Path(args.output).with_suffix(".dot").write_text(dot_src, encoding="utf-8")
    gv = run_dot(dot_path, dot_src)
    nodes, clusters = parse_gv(gv)

    # gan waypoints tu graphviz vao edges (theo thu tu dot xuat)
    gv_edges = []
    for ed in gv.get("edges", []):
        pts = []
        for d in ed.get("_draw_", []):
            if d.get("op") in ("b", "B", "L", "p", "P") and "points" in d:
                H = float(gv["bb"].split(",")[3])
                pts = [(float(px), H - float(py)) for px, py in d["points"]]
                break
        gv_edges.append(pts)

    # build edges voi waypoints theo cung thu tu
    title = design.get("title", "Conceptual Data Model")
    xml = emit_with_points(entities, edges, gv_edges, color_map, nodes, clusters, title)
    Path(args.output).write_text(xml, encoding="utf-8")
    n_core = sum(1 for e in entities.values() if e["core"])
    print(f"OK: {n_core} entity loi + {len(entities)-n_core} entity con, {len(edges)} quan he "
          f"-> {Path(args.output).resolve()}")


def emit_with_points(entities, edges, gv_edges, color_map, nodes, clusters, title):
    """Nhu emit() nhung dung waypoints da tinh san (gv_edges) theo thu tu edges."""
    zone_style = ("rounded=1;whiteSpace=wrap;html=1;verticalAlign=top;align=center;"
                  "fontSize=15;fontStyle=1;opacity=40;strokeWidth=2;spacingTop=6;arcSize=2;")
    def table_style(core):
        f, fc, sc = (CORE_FILL, CORE_FONT, CORE_STROKE) if core else (CHILD_FILL, CHILD_FONT, CHILD_STROKE)
        return ("swimlane;fontStyle=1;childLayout=stackLayout;horizontal=1;startSize=30;"
                "horizontalStack=0;resizeParent=1;resizeParentMax=0;collapsible=0;"
                f"marginBottom=0;whiteSpace=wrap;html=1;fillColor={f};fontColor={fc};"
                f"strokeColor={sc};fontSize=12;")
    row_style = ("text;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;"
                 "spacingLeft=8;spacingRight=4;overflow=hidden;rotatable=0;fontSize=11;fontColor=#2c3e50;")
    edge_style = ("edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;fontSize=12;"
                  "endArrow=none;startArrow=none;strokeColor=#5a6c7d;strokeWidth=1.5;")
    lbl_style = ("edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;"
                 "fontSize=13;fontStyle=1;fontColor=#b00020;labelBackgroundColor=#ffffff;")

    cells = ['<mxCell id="0" />', '<mxCell id="1" parent="0" />']
    for i, (label, x, y, w, h) in enumerate(clusters):
        fill, stroke = color_map.get(label, ("#f5f5f5", "#999999"))
        cells.append(
            f'<mxCell id="zone{i}" value="{esc(label)}" style="{zone_style}fillColor={fill};'
            f'strokeColor={stroke};" vertex="1" parent="1"><mxGeometry x="{x:.0f}" y="{y:.0f}" '
            f'width="{w:.0f}" height="{h:.0f}" as="geometry"/></mxCell>'
        )
    for eid, (x, y, w, h) in nodes.items():
        e = entities.get(eid)
        if not e:
            continue
        rh = ent_h(e)
        cells.append(
            f'<mxCell id="{eid}" value="{esc(e["label"])}" style="{table_style(e["core"])}" '
            f'vertex="1" parent="1"><mxGeometry x="{x:.0f}" y="{y:.0f}" width="{ENTITY_W}" '
            f'height="{rh}" as="geometry"/></mxCell>'
        )
        for j, a in enumerate((e["attrs"][:MAX_ATTRS] or ["..."]), start=1):
            cells.append(
                f'<mxCell id="{eid}_a{j}" value="{esc(a)}" style="{row_style}" vertex="1" parent="{eid}">'
                f'<mxGeometry y="{TITLE_H + (j-1)*ROW_H}" width="{ENTITY_W}" height="{ROW_H}" as="geometry"/></mxCell>'
            )
    for k, (ed, pts) in enumerate(zip(edges, gv_edges), start=1):
        if ed["src"] not in nodes or ed["tgt"] not in nodes:
            continue
        sc, tc = card_pair(ed["type"])
        label = ed.get("label", "")
        waypts = ""
        if len(pts) > 2:
            inner = pts[1:-1]
            waypts = ('<Array as="points">' +
                      "".join(f'<mxPoint x="{px:.0f}" y="{py:.0f}"/>' for px, py in inner) + "</Array>")
        eid = f"r{k}"
        cells.append(
            f'<mxCell id="{eid}" value="{esc(label)}" style="{edge_style}" edge="1" parent="1" '
            f'source="{ed["src"]}" target="{ed["tgt"]}"><mxGeometry relative="1" as="geometry">'
            f'{waypts}</mxGeometry></mxCell>'
        )
        cells.append(
            f'<mxCell id="{eid}_cs" value="{sc}" style="{lbl_style}" vertex="1" connectable="0" parent="{eid}">'
            f'<mxGeometry x="-0.8" relative="1" as="geometry"><mxPoint as="offset"/></mxGeometry></mxCell>'
        )
        cells.append(
            f'<mxCell id="{eid}_ct" value="{tc}" style="{lbl_style}" vertex="1" connectable="0" parent="{eid}">'
            f'<mxGeometry x="0.8" relative="1" as="geometry"><mxPoint as="offset"/></mxGeometry></mxCell>'
        )
    max_x = max((x + w for (_, x, y, w, h) in clusters), default=1200) + 60
    max_y = max((y + h for (_, x, y, w, h) in clusters), default=900) + 60
    return (
        f'<mxfile host="app.diagrams.net"><diagram name="{esc(title)}">'
        f'<mxGraphModel grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" '
        f'fold="1" pageScale="1" pageWidth="{int(max_x)}" pageHeight="{int(max_y)}" math="0" shadow="0">'
        f'<root>' + "".join(cells) + '</root></mxGraphModel></diagram></mxfile>'
    )


if __name__ == "__main__":
    main()
