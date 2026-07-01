# Agent 2: Table Classifier

## core_entity
- `ChuongTrinhDaoTao`: Learning & Study; role `core`. Reference-like columns: macosodaotao, machuongtrinhdaotao, loaichuongtrinhdaotao, loaichuongtrinhlkdaotao, hinhthucdaotaocn, maxa, matinh, quocgia, trangthaictdt.
- `cosogiaoducdaihoc`: Institution & Organization; role `core`. Reference-like columns: macosodaotao, maddtc, hinhthucthanhlap, loaihinhtruong, loaihinhcsdt, trangthaihdcs, loaitruong.
- `DanhSachNganhDaoTao`: Learning & Study; role `core`. Reference-like columns: macosodaotao, manganhmolandau, hinhthucdaotaocn, trangthai.
- `ThongTinCanBoGiangVien`: Staff & Lecturer; role `core`. Reference-like columns: macosodaotao, macanbo, masobhxh, trangthailv, mangoaingu, makhungnlngoaingu.
- `ttchunghocvien`: Learner Profile; role `core`. Reference-like columns: macosodaotao, mahocvien, masobhxh, loaikhuyettat.
- `VanBangChungChi`: Credential & Certificate; role `core`. Reference-like columns: mahocvien, gioitinh, dantoc, matruong, hinhthucdaotao, trangthai, madinhdanhvbcc.

## transaction_or_event
- `KhenThuong`: Reward & Discipline; role `core`. Reference-like columns: macosodaotao, loaikhenthuong, hinhthuckhenthuong.
- `KyLuat`: Reward & Discipline; role `core`. Reference-like columns: macosodaotao, maloaikyluat.
- `QuaTrinhCongTacCuaCanBoGiangVien`: Staff & Lecturer; role `core`. Reference-like columns: macosodaotao, manganhgiangday.
- `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien`: Staff & Lecturer; role `core`. Reference-like columns: macosodaotao, loaihinhdaotao.
- `thongtinhoctapsvdh`: Learning & Study; role `core`. Reference-like columns: macosodaotao, mahocvien, loaihocvien, loaihinhdaotao, mahinhthucdaotao, manganh, matrangthai, loaitotnghiep.
- `ThongTinHocTapSVDH_QuyetDinhThoiHocBaoLuu`: Learning & Study; role `decision detail`.
- `VanBangChungChi_ThongTinHieuChinh`: Credential & Certificate; role `change/history detail`.

## sub_entity_extension
- `csvcvatrangthietbidatdai_doituongsohuu_dinhdanhtochuc`: Institution & Organization; role `ownership subtype`. Reference-like columns: maddtc.
- `csvcvatrangthietbidatdai_doituongsohuu_nguoivn`: Institution & Organization; role `person-nationality subtype`.
- `ketquahoctapththcsthpttx_nguoivn`: Reference / Other; role `person-nationality subtype`.
- `KhenThuong_CongDanNuocNgoai`: Reward & Discipline; role `person-nationality subtype`.
- `KhenThuong_NguoiVN`: Reward & Discipline; role `person-nationality subtype`.
- `KyLuat_CongDanNuocNgoai`: Reward & Discipline; role `person-nationality subtype`.
- `KyLuat_NguoiVN`: Reward & Discipline; role `person-nationality subtype`.
- `PhongBanDonViCongTac_CongDanNuocNgoai`: Staff & Lecturer; role `person-nationality subtype`.
- `PhongBanDonViCongTac_NguoiVN`: Staff & Lecturer; role `person-nationality subtype`.
- `QuaTrinhCongTacCuaCanBoGiangVien_CongDanNuocNgoai`: Staff & Lecturer; role `person-nationality subtype`.
- `QuaTrinhCongTacCuaCanBoGiangVien_NguoiVN`: Staff & Lecturer; role `person-nationality subtype`.
- `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_CongDanNuocNgoai`: Staff & Lecturer; role `person-nationality subtype`.
- `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_NguoiVN`: Staff & Lecturer; role `person-nationality subtype`.
- `ThongTinCanBoGiangVien_CongDanNuocNgoai`: Staff & Lecturer; role `person-nationality subtype`.
- `ThongTinCanBoGiangVien_CongDanNuocNgoai_GiayToDinhDanhNN`: Staff & Lecturer; role `identity-document subtype`. Reference-like columns: loaigiaytoxnc.
- `ThongTinCanBoGiangVien_NguoiVN`: Staff & Lecturer; role `person-nationality subtype`. Reference-like columns: gioitinh, dantoc, tongiao, quoctich.
- `ThongTinCanBoGiangVien_NguoiVN_GiayToDinhDanhCN`: Staff & Lecturer; role `identity-document subtype`. Reference-like columns: loaigiayto.
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai`: Reference / Other; role `person-nationality subtype`.
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn`: Reference / Other; role `person-nationality subtype`. Reference-like columns: gioitinh, dantoc, quoctich.
- `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai`: Reference / Other; role `person-nationality subtype`.
- `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhdanh`: Reference / Other; role `identity-document subtype`. Reference-like columns: loaigiaytoxnc.
- `thongtinhocsinhcapmnththcsthpttx_nguoivn`: Reference / Other; role `person-nationality subtype`. Reference-like columns: gioitinh, dantoc, quoctich.
- `thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn`: Reference / Other; role `identity-document subtype`. Reference-like columns: loaigiayto.
- `thongtinhoctapsvdh_congdannuocngoai`: Learning & Study; role `person-nationality subtype`.
- `thongtinhoctapsvdh_nguoivn`: Learning & Study; role `person-nationality subtype`.
- `ttchunghocvien_congdannuocngoai`: Learner Profile; role `person-nationality subtype`. Reference-like columns: maxa, matinh, quocgia.
- `ttchunghocvien_congdannuocngoai_giaytodinhdanhnn`: Learner Profile; role `identity-document subtype`. Reference-like columns: loaigiaytoxnc.
- `ttchunghocvien_nguoivn`: Learner Profile; role `person-nationality subtype`. Reference-like columns: gioitinh, dantoc, tongiao, quoctich, maxa, matinh, quocgia, maxa_2, matinh_2, maxa_3, matinh_3.
- `ttchunghocvien_nguoivn_giaytodinhdanhcn`: Learner Profile; role `identity-document subtype`. Reference-like columns: loaigiayto.

## asset_facility
- `csvcvatrangthietbidatdai`: Institution & Organization; role `core`. Reference-like columns: macosodaotao, magcn, hinhthucsohuu, maxa, matinh, tinhtrangsudungdd.
- `phonghocgiangduongvahoitruong`: Institution & Organization; role `core`. Reference-like columns: macosodaotao, maphonghocgdht, hinhthucsohuu, tinhtrangcsvc, loaiphonghoc, loaidean, maxa, matinh, tinhtrangsudungphgdhv.
- `thongtintoanha`: Institution & Organization; role `core`. Reference-like columns: macosodaotao, matoanha, hinhthucsohuu, maxa, matinh, tinhtrangsudung.

## organization_structure
- `PhongBanDonViCongTac`: Staff & Lecturer; role `core`. Reference-like columns: macosodaotao, maphongban, hinhthucbonhiem.
- `thongtincocautochuc`: Institution & Organization; role `core`. Reference-like columns: macosodaotao, loaiphongban, maphongban, maddtc, maphongbancha, trangthaihdtc.

## core_or_fact
- `cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr`: Institution & Organization; role `core`. Reference-like columns: mavungkhokhan.
- `cosovatchatphonghoctieuhoc`: Institution & Organization; role `core`. Reference-like columns: matruong, madiemtruong, mabaocao.
- `decimal__18.4`: Reference / Other; role `core`.
- `decimal__20`: Reference / Other; role `core`.
- `ketquahoctapththcsthpttx`: Reference / Other; role `core`. Reference-like columns: manhomcaphoc, matruong, makhoi, malop, mahocsinh, mahocluc, mahanhkiem, madanhhieu.
- `ketquahoctapththcsthpttx_cogndannuocngoai`: Reference / Other; role `core`.
- `ketquahoctapththcsthpttx_diemmon`: Reference / Other; role `core`. Reference-like columns: mamonhoc.
- `ketquahoctapththcsthpttx_khenthuong`: Reward & Discipline; role `core`.
- `ketquahoctapththcsthpttx_kyluat`: Reward & Discipline; role `core`.
- `lopmamnon`: Reference / Other; role `core`. Reference-like columns: matruong, madiemtruong, makhoi, malop, manhomtuoimamnon, magiaoviencn, malopghep, mahocbantru.
- `quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx`: Staff & Lecturer; role `core`. Reference-like columns: manhomcaphoc, matruong, magiaovien, manhomchuyennganh, hinhthucdaotao.
- `thongtindiemtruongcapmnththcsthpttx`: Reference / Other; role `core`. Reference-like columns: manhomcaphoc, matruong, madiemtruong.
- `thongtindiemtruongchinhcapmnththcsthpt`: Reference / Other; role `core`. Reference-like columns: maddtc, matruong, manhomcaphoc, maloaihinhtruong, maloaitruong, makhuvuc, machatluonggiaoduc, maduan, mavung, mavungkhokhan.
- `thongtindoingucanbocsgdcapmamnonththcsthpttx`: Reference / Other; role `core`. Reference-like columns: manhomcaphoc, matruong, magiaovien, matrangthailv, masobhxh, manhomcanbo, maloaicanbo, mahinhthuchopdong, mangach, masongach, matiengdantoc, maboiduongthuongxuyen.
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_monday`: Reference / Other; role `core`. Reference-like columns: mamonday.
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem`: Reference / Other; role `core`. Reference-like columns: mamonkiemnhiem.
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu`: Reference / Other; role `core`. Reference-like columns: mangoaingu.
- `thongtinhocsinhcapmnththcsthpttx`: Reference / Other; role `core`. Reference-like columns: manhomcaphoc, matruong, makhoi, malop, mahocsinh, matrangthaihientai, malydothoihoc, makhuvuc, maloaikhuyettat, malophuongnghiep, madienchinhsach, mahocbantru.
- `thongtinhocsinhcapmnththcsthpttx_khenthuong`: Reward & Discipline; role `core`. Reference-like columns: makhenthuong.
- `thongtinhocsinhcapmnththcsthpttx_nguoidodau`: Reference / Other; role `core`.
- `thongtinhocsinhcapmnththcsthpttx_thongtincha`: Reference / Other; role `core`.
- `thongtinhocsinhcapmnththcsthpttx_thongtinme`: Reference / Other; role `core`.
- `thongtinkhenthuonggiaoviencapmnththcsthpttx`: Reward & Discipline; role `core`. Reference-like columns: manhomcaphoc, matruong, magiaovien, makhenthuonggv, maloaikhenthuong.
- `thongtinkyluatgiaoviencapmnththcsthpttx`: Reward & Discipline; role `core`. Reference-like columns: manhomcaphoc, matruong, magiaovien, makyluatgv, loaikyluat.
- `thongtinlophocgdtx`: Reference / Other; role `core`. Reference-like columns: matrungtam, malop, magiaoviencn, makhoi, makieulop, hinhthuchoctap, malopdaotaoboiduong, malophuongnghiepdaynghe, masobuoihoctrentuan.
- `thongtinlophocgdtx_monhoc`: Reference / Other; role `core`. Reference-like columns: mamonhoc, magiaovien.
- `thongtinlophocthcsthpt`: Reference / Other; role `core`. Reference-like columns: manhomcaphoc, matruong, malop, magiaoviencn, makhoi, madiemtruong, madanhmucngoaingu1, madanhmucngoaingu2, malopghep, mahocbantru, masobuoihoctrentuan, maphanban.
- `thongtinlophocthcsthpt_monhoc`: Reference / Other; role `core`. Reference-like columns: mamonhoc, magiaovien.
- `thongtinlophoctieuhoc`: Reference / Other; role `core`. Reference-like columns: matruong, malop, makhoi, madiemtruong, madanhmucngoaingu1, madanhmucngoaingu2, masotietngoaingu, malopghep, mahocbantru, masobuoihoctrentuan.
- `thongtinsohocbasothcsthpt`: Reference / Other; role `core`. Reference-like columns: trangthaithongtinhocba, madinhdanhhocba, masogd, matruong, macaphoc, mahocsinh, gioitinh, dantoc, quoctich, makhoi.
- `thongtinsohocbasothcsthpt_bangdiem`: Reference / Other; role `core`. Reference-like columns: mamonhoc.
- `thongtinsohocbasothcsthpt_chungchi`: Credential & Certificate; role `core`. Reference-like columns: loaichungchi.
- `thongtinsohocbasothcsthpt_quatrinhhoctap`: Reference / Other; role `core`.
- `thongtinsohocbasotieuhoc`: Reference / Other; role `core`. Reference-like columns: trangthaithongtinhocba, madinhdanhhocba, masogd, matruong, macaphoc, mahocsinh, gioitinh, dantoc, quoctich, makhoi.
- `thongtinsohocbasotieuhoc_dsbangdiem`: Reference / Other; role `core`. Reference-like columns: mamonhoc.
- `thongtinsohocbasotieuhoc_quatrinhhoctap`: Reference / Other; role `core`.
