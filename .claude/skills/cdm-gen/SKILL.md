---
name: cdm-gen
description: Sinh Conceptual Data Model (CDM) truc quan dang draw.io tu file Excel schema DB (Book-style). Dung khi nguoi dung muon dao nguoc 1 schema vat ly (bang + cot) thanh mo hinh khai niem, hoac chuyen file Excel cau truc bang/cot thanh so do CDM .drawio. Claude tu nhan dien entity, gom bang, suy luan quan he 1-1/1-n/n-n theo chuan CDM/LDM va 5 nhom du lieu TT08/2025/TT-BCA.
---

# CDM Generator Skill

Dao nguoc 1 schema DB vat ly (file Excel Book-style) thanh **Conceptual Data Model**
truc quan dang draw.io. Claude dong vai chuyen gia data modeling — **khong can goi API LLM ngoai**,
chinh Claude (trong phien nay) lam buoc thiet ke.

## Quy trinh 3 buoc

```
Excel (.xlsx)  ──parse_schema.py──►  schema_summary.json
                                          │
                                   (Claude doc & thiet ke)
                                          ▼
                                     design.json
                                          │
                                 ──build_drawio.py──►  cdm.drawio
```

### Buoc 1 — Trich xuat schema (deterministic, chay script)
```
python cdm_skill/parse_schema.py <book.xlsx> -o cdm_output/schema_summary.json
```
Script tu: gom suffix tables vao base, loc bang rac, giu PK/FK/ma*/mo ta.

### Buoc 2 — Thiet ke CDM (Claude lam, KHONG goi API)
Doc `schema_summary.json`, ap dung kien thuc ben duoi, roi ghi `cdm_output/design.json`
theo dung [format design](#format-designjson).

### Buoc 3 — Sinh drawio (deterministic, chay script)

**Khuyen dung — Graphviz engine** (layout theo do lien ket, auto-route tranh bang):
```
python cdm_skill/build_graphviz.py cdm_output/design.json -o cdm_output/cdm.drawio --summary cdm_output/schema_summary.json --rankdir TB
```
- `--rankdir TB` = dai ngang (dai domain), `LR` = dai doc. Chon theo so domain.
- Yeu cau Graphviz (`dot`) da cai. Neu chua co, build_graphviz.py se bao loi.

**Fallback khong can Graphviz** (layout luoi don gian):
```
python cdm_skill/build_drawio.py cdm_output/design.json -o cdm_output/cdm.drawio --summary cdm_output/schema_summary.json
```
Ca 2: khong chong box, crow's foot cardinality (ERone/ERmany).
build_graphviz THEM: dinh tuyen edge tranh vat can (khong chay qua bang) + xep theo do lien ket.

---

## Kien thuc 1 — CDM vs LDM vs Physical

| Muc | Conceptual (CDM) | Logical (LDM) | Physical |
|---|---|---|---|
| Tra loi | Co nhung **thuc the** gi & lien quan ra sao | Them **thuoc tinh, khoa, cardinality** chi tiet | Bang, cot, index, kieu DB cu the |
| Quan he n-n | Ve thang la 1 duong n-n (KHONG tach bang noi) | Co the tach bang trung gian | Bang junction that su |
| Khoa | Chi khoa nghiep vu chinh | PK/FK day du | PK/FK + rang buoc DB |

**Muc tieu skill = CDM** (co lay 1 it thuoc tinh khoa cho de doc, nghieng ve LDM nhe).

## Kien thuc 2 — Quy tac dao nguoc (reverse engineering) — theo TEMPLATE

Bang con (B bat dau bang `A + "_"`) duoc xu ly theo CARDINALITY (giong file mau Logical):

1. **Bien the quoc tich 1-1** (`_NguoiVN`, `_CongDanNuocNgoai`) → GOP thanh DONG phu trong box cha (hien `[nguoivn]`).
2. **Bang con 1-1** (`_ThongTinCha`, `_ThongTinMe`, `_ThongTinHieuChinh`, `_QuyetDinhThoiHocBaoLuu`) → box RIENG, quan he **1-1**.
3. **Bang con 1-n** (con lai: `_GiayToDinhDanh*`, `_ds*`, `_DiemMon`, `_MonHoc`, `_MonDay`, `_MonKiemNhiem`, `_NgoaiNgu`, `_KhenThuong`, `_KyLuat`, `_BangDiem`, `_ChungChi`, `_QuaTrinhHocTap`...) → box RIENG, quan he **1-n**.
   - Prefix quoc tich long nhau duoc strip: `X_nguoivn_giaytodinhdanhcn` → box con `giaytodinhdanhcn`.
4. **Loc bang rac**: ten la kieu du lieu (`decimal__20`, `numeric__18,4`), hoac chi gom so/dau cau.
5. **Giu nguyen ten bang goc** lam `base_table` (KHONG paraphrase).
6. **Khong copy FK ky thuat thanh entity** — FK chi la duong quan he.

parse_schema.py v2 da tu dong lam buoc 1-4 va xuat `child_entities` + `merged_variants` cho moi base.

## Kien thuc 3 — Suy luan cardinality

| Tin hieu trong schema | Cardinality | Vi du |
|---|---|---|
| Khoa nghiep vu chung (vd `matruong`) xuat hien o ben "nhieu" | **1-n** | Truong 1-n Lop |
| Bang con chia se PK voi cha (subtype 1:1) | **1-1** | Hoc sinh 1-1 chi tiet NguoiVN |
| Bang junction (chi gom 2+ FK, it thuoc tinh rieng) | **n-n** | HocVien n-n Mon (qua bang dang ky) |
| FK don huong tu A → B | **1-n** (B la "1", A la "nhieu") | |

Khi nghi ngo, mac dinh **1-n**. Chi danh **n-n** khi co bang noi ro rang.
Chi danh **1-1** khi 2 entity chia se cung khoa dinh danh ca nhan.

## Kien thuc 4 — 5 nhom du lieu TT08/2025/TT-BCA

Quy chuan ky thuat quoc gia ve CSDL tong hop quoc gia chia du lieu thanh:

| Nhom TT08 | Map tu tin hieu schema |
|---|---|
| **Con nguoi** | bang co `_NguoiVN`/`_CongDanNuocNgoai`/`hoten`/`ngaysinh`/`sodinhdanh`/`mahocsinh`/`macanbo` |
| **Phap nhan / To chuc** | `_DinhDanhToChuc`, `cocautochuc`, `phongban`, `cosogiaoduc*`, `macosodaotao` |
| **Tai san** | `toanha`, `csvc*`, `datdai`, `phonghoc`, `trangthietbi`, `magcn` |
| **Dia chi so / Dinh danh dia diem** | `matinh`, `maxa`, `diachi`, `matoanha`, `maphonghoc*` |
| **Du lieu tham chieu dung chung** | `dantoc`, `tongiao`, `quoctich`, `loai*`, `trangthai*` (danh muc) |

Khi dat **domain** cho entity, uu tien anh xa ve 5 nhom nay (hoac nhom nghiep vu cu the
hon neu schema co cau truc ro rang, vd "Hoc sinh & Ket qua", "Can bo giang vien").
Moi domain 4-8 entity, tong 6-10 domain la dep.

## Nguyen tac truc quan (build_graphviz.py — KHUYEN DUNG, theo template)

- **Layout = Graphviz** (`dot`, splines=ortho): xep theo do lien ket + dinh tuyen edge **tranh bang**.
- Cardinality = **NHAN CHU "1"/"n"** canh dau duong (KHONG crow's foot).
- **Entity loi (base) to GREEN** (#008a00), **entity con to TRANG** — phan biet ro.
- Domain = **zone mau** bao quanh (ket hop: vua thay domain vua noi entity loi).
- Moi entity: tieu de + toi da 7 thuoc tinh khoa (PK + ma* + attr); bien the quoc tich hien `[...]`.
- `--rankdir TB` (rong ngang) hoac `LR` (dai doc).

Lenh: `python cdm_skill/build_graphviz.py design.json --summary schema_summary.json -o cdm.drawio --rankdir TB`

## Format design.json

```json
{
  "title": "CDM - <ten he thong>",
  "domains": [
    {"name": "Con nguoi", "fill_color": "#dae8fc", "stroke_color": "#6c8ebf"}
  ],
  "entities": [
    {"display_name": "Hoc sinh", "base_table": "thongtinhocsinh...",
     "domain": "Con nguoi", "key_attrs": ["mahocsinh (PK)", "hoten", "ngaysinh"]}
  ],
  "relationships": [
    {"from": "thongtindiemtruong...", "to": "thongtinhocsinh...",
     "type": "1-n", "label": "co hoc sinh"}
  ]
}
```

- `base_table`, `from`, `to` PHAI khop chinh xac `base_table` trong `schema_summary.json`.
- `key_attrs` co the bo trong → script tu lay tu `--summary`.
- Mau pastel goi y: `#dae8fc #d5e8d4 #ffe6cc #e1d5e7 #b0e3e6 #fff2cc #f8cecc #d0cee2`.

## Checklist truoc khi ban giao

- [ ] Moi entity nghiep vu deu co domain thuoc 6-10 nhom (uu tien 5 nhom TT08).
- [ ] Khong bo sot entity that (chi bo bang rac).
- [ ] Quan he phu het cac khoa nghiep vu chung; co du 1-1/1-n/n-n khi phu hop.
- [ ] Chay build_drawio.py thanh cong, mo .drawio kiem tra khong chong cheo.
