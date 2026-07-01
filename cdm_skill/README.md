# CDM Skill — Excel schema → Conceptual Data Model (.drawio)

Bo cong cu dao nguoc schema DB vat ly (Excel Book-style) thanh **CDM truc quan**.
Dung qua skill `/cdm-gen` (Claude tu thiet ke, khong goi API ngoai) hoac chay tay 3 buoc.

## Chay tay

```powershell
# 1. Trich xuat schema gon
.\.venv\Scripts\python.exe cdm_skill\parse_schema.py <book.xlsx> -o cdm_output\schema_summary.json

# 2. Claude doc schema_summary.json -> ghi cdm_output\design.json
#    (xem .claude/skills/cdm-gen/SKILL.md cho quy tac thiet ke + 5 nhom TT08/2025)

# 3. Sinh drawio truc quan
.\.venv\Scripts\python.exe cdm_skill\build_drawio.py cdm_output\design.json -o cdm_output\cdm.drawio --summary cdm_output\schema_summary.json
```

## Dac diem truc quan

- Moi domain = 1 zone mau, entity xep doc trong zone, zone xep luoi → **0 box chong nhau**.
- Edge `orthogonalEdgeStyle`, khong waypoint thu cong → **draw.io tu route, khong chong duong**.
- Cardinality crow's foot ER: `1-1`, `1-n`, `n-n`.
- Moi entity hien tieu de + toi da 6 thuoc tinh khoa (PK + ma* + attr).

## Format

`build_drawio.py` nhan ca 2 dang:
- `design.json` (key `from`/`to`) — dau ra chuan cua skill.
- `cdm_config.json` (key `from_table`/`to_table`, `merged_tables`) — tuong thich nguoc.

Chi tiet format & quy tac thiet ke: [.claude/skills/cdm-gen/SKILL.md](../.claude/skills/cdm-gen/SKILL.md)
