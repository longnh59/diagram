"""
Claude-designed CDM for Book1.xlsx
- 8 domains, 32 entities, 31 relationships
- Generated directly from Claude's analysis of all 83 tables
- Output: cdm_output/claude_cdm.drawio
"""
import base64, html, sys
from collections import defaultdict, OrderedDict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from generate_cdm import (
    build_metadata, build_drawio_page,
    layout_cdm_grid, compute_zone_cells_from_positions,
    select_identity_columns,
)

OUTPUT_DIR = Path("cdm_output")
OUTPUT_FILE = OUTPUT_DIR / "claude_cdm.drawio"

# ── Claude CDM Design ───────────────────────────────────────────────────────

DOMAINS = [
    {"name": "Co so giao duc",     "fill_color": "#dae8fc", "stroke_color": "#6c8ebf"},
    {"name": "To chuc noi bo",     "fill_color": "#e4d9f5", "stroke_color": "#9673a6"},
    {"name": "Co so vat chat",     "fill_color": "#e0f0e0", "stroke_color": "#5a9a5a"},
    {"name": "Chuong trinh hoc",   "fill_color": "#fff2cc", "stroke_color": "#c8a800"},
    {"name": "Nguoi hoc",          "fill_color": "#ffe6d5", "stroke_color": "#d6763b"},
    {"name": "Ket qua hoc tap",    "fill_color": "#d5eef5", "stroke_color": "#2e8aaa"},
    {"name": "Nhan su",            "fill_color": "#fde8f0", "stroke_color": "#c04080"},
    {"name": "Thi dua - Ky luat",  "fill_color": "#f0f0f0", "stroke_color": "#888888"},
]

ENTITIES = [
    # Co so giao duc
    {"base_table": "cosogiaoducdaihoc",                                                        "domain": "Co so giao duc"},
    {"base_table": "thongtindiemtruongchinhcapmnththcsthpt",                                   "domain": "Co so giao duc"},
    {"base_table": "thongtindiemtruongcapmnththcsthpttx",                                      "domain": "Co so giao duc"},
    {"base_table": "cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr",         "domain": "Co so giao duc"},
    # To chuc noi bo
    {"base_table": "thongtincocautochuc",                                                      "domain": "To chuc noi bo"},
    {"base_table": "PhongBanDonViCongTac",                                                     "domain": "To chuc noi bo"},
    # Co so vat chat
    {"base_table": "thongtintoanha",                                                           "domain": "Co so vat chat"},
    {"base_table": "csvcvatrangthietbidatdai",                                                 "domain": "Co so vat chat"},
    {"base_table": "phonghocgiangduongvahoitruong",                                            "domain": "Co so vat chat"},
    {"base_table": "cosovatchatphonghoctieuhoc",                                               "domain": "Co so vat chat"},
    # Chuong trinh hoc
    {"base_table": "DanhSachNganhDaoTao",                                                      "domain": "Chuong trinh hoc"},
    {"base_table": "ChuongTrinhDaoTao",                                                        "domain": "Chuong trinh hoc"},
    {"base_table": "lopmamnon",                                                                "domain": "Chuong trinh hoc"},
    {"base_table": "thongtinlophoctieuhoc",                                                    "domain": "Chuong trinh hoc"},
    {"base_table": "thongtinlophocthcsthpt",                                                   "domain": "Chuong trinh hoc"},
    {"base_table": "thongtinlophocgdtx",                                                       "domain": "Chuong trinh hoc"},
    # Nguoi hoc
    {"base_table": "ttchunghocvien",                                                           "domain": "Nguoi hoc"},
    {"base_table": "thongtinhocsinhcapmnththcsthpttx",                                         "domain": "Nguoi hoc"},
    # Ket qua hoc tap
    {"base_table": "thongtinhoctapsvdh",                                                       "domain": "Ket qua hoc tap"},
    {"base_table": "VanBangChungChi",                                                          "domain": "Ket qua hoc tap"},
    {"base_table": "ketquahoctapththcsthpttx",                                                 "domain": "Ket qua hoc tap"},
    {"base_table": "thongtinsohocbasotieuhoc",                                                 "domain": "Ket qua hoc tap"},
    {"base_table": "thongtinsohocbasothcsthpt",                                                "domain": "Ket qua hoc tap"},
    # Nhan su
    {"base_table": "ThongTinCanBoGiangVien",                                                   "domain": "Nhan su"},
    {"base_table": "QuaTrinhCongTacCuaCanBoGiangVien",                                         "domain": "Nhan su"},
    {"base_table": "QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien",                                 "domain": "Nhan su"},
    {"base_table": "thongtindoingucanbocsgdcapmamnonththcsthpttx",                             "domain": "Nhan su"},
    {"base_table": "quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx",                          "domain": "Nhan su"},
    # Thi dua - Ky luat
    {"base_table": "KhenThuong",                                                               "domain": "Thi dua - Ky luat"},
    {"base_table": "KyLuat",                                                                   "domain": "Thi dua - Ky luat"},
    {"base_table": "thongtinkhenthuonggiaoviencapmnththcsthpttx",                              "domain": "Thi dua - Ky luat"},
    {"base_table": "thongtinkyluatgiaoviencapmnththcsthpttx",                                  "domain": "Thi dua - Ky luat"},
]

RELATIONSHIPS = [
    # Dai hoc
    ("cosogiaoducdaihoc",       "thongtincocautochuc",                                       "1-n co don vi"),
    ("cosogiaoducdaihoc",       "thongtintoanha",                                            "1-n co toa nha"),
    ("cosogiaoducdaihoc",       "csvcvatrangthietbidatdai",                                  "1-n co CSVC"),
    ("cosogiaoducdaihoc",       "phonghocgiangduongvahoitruong",                             "1-n co phong hoc"),
    ("cosogiaoducdaihoc",       "DanhSachNganhDaoTao",                                       "1-n mo nganh"),
    ("cosogiaoducdaihoc",       "ChuongTrinhDaoTao",                                         "1-n co CTDT"),
    ("cosogiaoducdaihoc",       "ttchunghocvien",                                            "1-n co hoc vien"),
    ("cosogiaoducdaihoc",       "ThongTinCanBoGiangVien",                                    "1-n co CBGV"),
    ("ttchunghocvien",          "thongtinhoctapsvdh",                                        "1-n hoc tap"),
    ("ttchunghocvien",          "VanBangChungChi",                                           "1-n co VB/CC"),
    ("ttchunghocvien",          "KhenThuong",                                                "1-n duoc khen"),
    ("ttchunghocvien",          "KyLuat",                                                    "1-n bi ky luat"),
    ("ThongTinCanBoGiangVien",  "PhongBanDonViCongTac",                                      "1-n thuoc don vi"),
    ("ThongTinCanBoGiangVien",  "QuaTrinhCongTacCuaCanBoGiangVien",                          "1-n cong tac"),
    ("ThongTinCanBoGiangVien",  "QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien",                  "1-n dao tao BD"),
    ("ThongTinCanBoGiangVien",  "KhenThuong",                                                "1-n duoc khen"),
    ("ThongTinCanBoGiangVien",  "KyLuat",                                                    "1-n bi ky luat"),
    # Pho thong
    ("thongtindiemtruongchinhcapmnththcsthpt", "lopmamnon",                                  "1-n co lop MN"),
    ("thongtindiemtruongchinhcapmnththcsthpt", "thongtinlophoctieuhoc",                      "1-n co lop TH"),
    ("thongtindiemtruongchinhcapmnththcsthpt", "thongtinlophocthcsthpt",                     "1-n co lop THCS/PT"),
    ("thongtindiemtruongchinhcapmnththcsthpt", "thongtinhocsinhcapmnththcsthpttx",           "1-n co hoc sinh"),
    ("thongtindiemtruongchinhcapmnththcsthpt", "thongtindoingucanbocsgdcapmamnonththcsthpttx","1-n co giao vien"),
    ("thongtindiemtruongchinhcapmnththcsthpt", "cosovatchatphonghoctieuhoc",                 "1-n co CSVC"),
    ("cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr", "thongtinlophocgdtx","1-n co lop GDTX"),
    ("thongtinlophoctieuhoc",   "thongtinhocsinhcapmnththcsthpttx",                          "1-n gom hoc sinh"),
    ("thongtinlophocthcsthpt",  "thongtinhocsinhcapmnththcsthpttx",                          "1-n gom hoc sinh"),
    ("thongtinlophocgdtx",      "thongtinhocsinhcapmnththcsthpttx",                          "1-n gom hoc sinh"),
    ("thongtinhocsinhcapmnththcsthpttx", "ketquahoctapththcsthpttx",                          "1-n co ket qua"),
    ("thongtinhocsinhcapmnththcsthpttx", "thongtinsohocbasotieuhoc",                          "1-n hoc ba TH"),
    ("thongtinhocsinhcapmnththcsthpttx", "thongtinsohocbasothcsthpt",                         "1-n hoc ba THCS/PT"),
    ("thongtindoingucanbocsgdcapmamnonththcsthpttx", "thongtinkhenthuonggiaoviencapmnththcsthpttx", "1-n duoc khen"),
    ("thongtindoingucanbocsgdcapmamnonththcsthpttx", "thongtinkyluatgiaoviencapmnththcsthpttx",     "1-n bi ky luat"),
    ("thongtindoingucanbocsgdcapmamnonththcsthpttx", "quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx","1-n duoc dao tao"),
]

def main():
    OUTPUT_DIR.mkdir(exist_ok=True)
    metadata = build_metadata("Book1.xlsx")

    # Build entity list từ Claude CDM design
    meta_table_map = metadata["tables"]
    meta_entity_map = {e["base_table"]: e for e in metadata["entities"]}

    entities = []
    for e_def in ENTITIES:
        bt = e_def["base_table"]
        meta_e = meta_entity_map.get(bt)
        entities.append({
            "entity":    bt,
            "base_table": bt,
            "domain":    e_def["domain"],
            "tables":    meta_e["tables"] if meta_e else [{"table": bt, "role": "core"}],
            "business_attributes": meta_e["business_attributes"] if meta_e else [],
        })

    positions  = layout_cdm_grid(entities)
    zone_cells = compute_zone_cells_from_positions(entities, positions, DOMAINS)
    diagram    = build_drawio_page(
        "Claude CDM", entities, RELATIONSHIPS, metadata,
        layout="cdm", zone_cells=zone_cells, cdm_positions=positions
    )
    xml = '<mxfile host="app.diagrams.net" pages="1">' + diagram + "</mxfile>"
    OUTPUT_FILE.write_text(xml, encoding="utf-8")

    b64 = base64.b64encode(xml.encode("utf-8")).decode("ascii")
    print(f"Entities: {len(entities)}")
    print(f"Relationships: {len(RELATIONSHIPS)}")
    print(f"File: {OUTPUT_FILE.resolve()}")
    print(f"\nhttps://app.diagrams.net/#base64,{b64}")

if __name__ == "__main__":
    main()
