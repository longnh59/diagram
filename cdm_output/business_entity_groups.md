# Agent 3: Business Entity Grouper

## Thongtindiemtruongchinhcapmnththcsthpt
- Domain: Reference / Other
- Physical tables:
  - `thongtindiemtruongchinhcapmnththcsthpt`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Thongtindiemtruongcapmnththcsthpttx
- Domain: Reference / Other
- Physical tables:
  - `thongtindiemtruongcapmnththcsthpttx`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Lopmamnon
- Domain: Reference / Other
- Physical tables:
  - `lopmamnon`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Thongtinhocsinhcapmnththcsthpttx
- Domain: Reference / Other
- Physical tables:
  - `thongtinhocsinhcapmnththcsthpttx`: core
  - `thongtinhocsinhcapmnththcsthpttx_nguoivn`: person-nationality subtype
  - `thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn`: identity-document subtype
  - `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai`: person-nationality subtype
  - `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhdanh`: identity-document subtype
  - `thongtinhocsinhcapmnththcsthpttx_thongtincha`: core
  - `thongtinhocsinhcapmnththcsthpttx_thongtinme`: core
  - `thongtinhocsinhcapmnththcsthpttx_nguoidodau`: core
  - `thongtinhocsinhcapmnththcsthpttx_khenthuong`: core
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Thongtindoingucanbocsgdcapmamnonththcsthpttx
- Domain: Reference / Other
- Physical tables:
  - `thongtindoingucanbocsgdcapmamnonththcsthpttx`: core
  - `thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn`: person-nationality subtype
  - `thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai`: person-nationality subtype
  - `thongtindoingucanbocsgdcapmamnonththcsthpttx_monday`: core
  - `thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem`: core
  - `thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu`: core
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Thongtinkhenthuonggiaoviencapmnththcsthpttx
- Domain: Reward & Discipline
- Physical tables:
  - `thongtinkhenthuonggiaoviencapmnththcsthpttx`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Thongtinkyluatgiaoviencapmnththcsthpttx
- Domain: Reward & Discipline
- Physical tables:
  - `thongtinkyluatgiaoviencapmnththcsthpttx`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx
- Domain: Staff & Lecturer
- Physical tables:
  - `quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Ketquahoctapththcsthpttx
- Domain: Reference / Other
- Physical tables:
  - `ketquahoctapththcsthpttx`: core
  - `ketquahoctapththcsthpttx_nguoivn`: person-nationality subtype
  - `ketquahoctapththcsthpttx_cogndannuocngoai`: core
  - `ketquahoctapththcsthpttx_khenthuong`: core
  - `ketquahoctapththcsthpttx_kyluat`: core
  - `ketquahoctapththcsthpttx_diemmon`: core
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Thongtinlophoctieuhoc
- Domain: Reference / Other
- Physical tables:
  - `thongtinlophoctieuhoc`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Cosovatchatphonghoctieuhoc
- Domain: Institution & Organization
- Physical tables:
  - `cosovatchatphonghoctieuhoc`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Thongtinlophocthcsthpt
- Domain: Reference / Other
- Physical tables:
  - `thongtinlophocthcsthpt`: core
  - `thongtinlophocthcsthpt_monhoc`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr
- Domain: Institution & Organization
- Physical tables:
  - `cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Decimal 20
- Domain: Reference / Other
- Physical tables:
  - `decimal__20`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Thongtinlophocgdtx
- Domain: Reference / Other
- Physical tables:
  - `thongtinlophocgdtx`: core
  - `thongtinlophocgdtx_monhoc`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Thongtinsohocbasotieuhoc
- Domain: Reference / Other
- Physical tables:
  - `thongtinsohocbasotieuhoc`: core
  - `thongtinsohocbasotieuhoc_quatrinhhoctap`: core
  - `thongtinsohocbasotieuhoc_dsbangdiem`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Decimal 18.4
- Domain: Reference / Other
- Physical tables:
  - `decimal__18.4`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Thongtinsohocbasothcsthpt
- Domain: Reference / Other
- Physical tables:
  - `thongtinsohocbasothcsthpt`: core
  - `thongtinsohocbasothcsthpt_quatrinhhoctap`: core
  - `thongtinsohocbasothcsthpt_chungchi`: core
  - `thongtinsohocbasothcsthpt_bangdiem`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Higher Education Institution
- Domain: Institution & Organization
- Physical tables:
  - `cosogiaoducdaihoc`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Organization Unit
- Domain: Institution & Organization
- Physical tables:
  - `thongtincocautochuc`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Building
- Domain: Institution & Organization
- Physical tables:
  - `thongtintoanha`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Land / Facility Asset
- Domain: Institution & Organization
- Physical tables:
  - `csvcvatrangthietbidatdai`: core
  - `csvcvatrangthietbidatdai_doituongsohuu_nguoivn`: person-nationality subtype
  - `csvcvatrangthietbidatdai_doituongsohuu_dinhdanhtochuc`: ownership subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Teaching Room / Hall
- Domain: Institution & Organization
- Physical tables:
  - `phonghocgiangduongvahoitruong`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Learner
- Domain: Learner Profile
- Physical tables:
  - `ttchunghocvien`: core
  - `ttchunghocvien_nguoivn`: person-nationality subtype
  - `ttchunghocvien_nguoivn_giaytodinhdanhcn`: identity-document subtype
  - `ttchunghocvien_congdannuocngoai`: person-nationality subtype
  - `ttchunghocvien_congdannuocngoai_giaytodinhdanhnn`: identity-document subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Postgraduate Study Record
- Domain: Learning & Study
- Physical tables:
  - `thongtinhoctapsvdh`: core
  - `thongtinhoctapsvdh_nguoivn`: person-nationality subtype
  - `thongtinhoctapsvdh_congdannuocngoai`: person-nationality subtype
  - `ThongTinHocTapSVDH_QuyetDinhThoiHocBaoLuu`: decision detail
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Credential / Certificate
- Domain: Credential & Certificate
- Physical tables:
  - `VanBangChungChi`: core
  - `VanBangChungChi_ThongTinHieuChinh`: change/history detail
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Reward
- Domain: Reward & Discipline
- Physical tables:
  - `KhenThuong`: core
  - `KhenThuong_NguoiVN`: person-nationality subtype
  - `KhenThuong_CongDanNuocNgoai`: person-nationality subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Discipline
- Domain: Reward & Discipline
- Physical tables:
  - `KyLuat`: core
  - `KyLuat_NguoiVN`: person-nationality subtype
  - `KyLuat_CongDanNuocNgoai`: person-nationality subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Staff / Lecturer
- Domain: Staff & Lecturer
- Physical tables:
  - `ThongTinCanBoGiangVien`: core
  - `ThongTinCanBoGiangVien_NguoiVN`: person-nationality subtype
  - `ThongTinCanBoGiangVien_NguoiVN_GiayToDinhDanhCN`: identity-document subtype
  - `ThongTinCanBoGiangVien_CongDanNuocNgoai`: person-nationality subtype
  - `ThongTinCanBoGiangVien_CongDanNuocNgoai_GiayToDinhDanhNN`: identity-document subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Work Unit Assignment
- Domain: Staff & Lecturer
- Physical tables:
  - `PhongBanDonViCongTac`: core
  - `PhongBanDonViCongTac_NguoiVN`: person-nationality subtype
  - `PhongBanDonViCongTac_CongDanNuocNgoai`: person-nationality subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Teaching / Work History
- Domain: Staff & Lecturer
- Physical tables:
  - `QuaTrinhCongTacCuaCanBoGiangVien`: core
  - `QuaTrinhCongTacCuaCanBoGiangVien_NguoiVN`: person-nationality subtype
  - `QuaTrinhCongTacCuaCanBoGiangVien_CongDanNuocNgoai`: person-nationality subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Staff Education / Training History
- Domain: Staff & Lecturer
- Physical tables:
  - `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien`: core
  - `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_NguoiVN`: person-nationality subtype
  - `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_CongDanNuocNgoai`: person-nationality subtype
- Collapse rule:
  - VN/foreign person variants are modeled as subtype attributes/components, not separate top-level CDM entities.

## Training Major
- Domain: Learning & Study
- Physical tables:
  - `DanhSachNganhDaoTao`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.

## Training Program
- Domain: Learning & Study
- Physical tables:
  - `ChuongTrinhDaoTao`: core
- Collapse rule:
  - Keep as a top-level conceptual entity or fact.
