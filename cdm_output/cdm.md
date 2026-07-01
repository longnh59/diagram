# Conceptual Data Model

- Physical tables retained after lowercase de-duplication: 83.
- FK columns marked in Excel: 276; resolved conceptual/physical relationships: 63.
- Many lookup-style FK columns are still unresolved because their reference/dictionary tables are not present in the workbook.
- Subtype tables for Vietnamese/foreign people and identity documents are collapsed into their parent conceptual entities.

## Conceptual Entities
### Thongtindiemtruongchinhcapmnththcsthpt
- Domain: Reference / Other
- Physical coverage: thongtindiemtruongchinhcapmnththcsthpt (core)
- Key business attributes: CoChatLuongToiThieu, CoChuongTrinhGiaoDucGioiTinh, CoChuongTrinhGiaoDucVeSinhDoiTay, CoCongTrinhVeSinhTheoGioiTinh, CoDay2BuoiNgay, CoDayNghePhoThong, CoDienLuoi, CoHaTangTiepCanHocSinhKhuyetTat, CoHocSinhBanTru, CoHocSinhKhuyetTat

### Thongtindiemtruongcapmnththcsthpttx
- Domain: Reference / Other
- Physical coverage: thongtindiemtruongcapmnththcsthpttx (core)
- Key business attributes: diachi_diachichitiet, dientich, kcdentruongchinh, madiemtruong, manhomcaphoc, matruong, phuongtiendilai, sodienthoai, tendiemtruong, diachi_mahuyen

### Lopmamnon
- Domain: Reference / Other
- Physical coverage: lopmamnon (core)
- Key business attributes: capnhatlopghep, coctcsgd, coctgdmnmoi, coday2buoingay, cotrekhuyettat, ghep2tuoi, ghep3tuoi, ghep4tuoi, lopbantru, lopghep

### Thongtinhocsinhcapmnththcsthpttx
- Domain: Reference / Other
- Physical coverage: thongtinhocsinhcapmnththcsthpttx (core), thongtinhocsinhcapmnththcsthpttx_nguoivn (person-nationality subtype), thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn (identity-document subtype), thongtinhocsinhcapmnththcsthpttx_congdannuocngoai (person-nationality subtype), thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhdanh (identity-document subtype), thongtinhocsinhcapmnththcsthpttx_thongtincha (core), thongtinhocsinhcapmnththcsthpttx_thongtinme (core), thongtinhocsinhcapmnththcsthpttx_nguoidodau (core), thongtinhocsinhcapmnththcsthpttx_khenthuong (core)
- Key business attributes: benhbamsinh, benhcoixuong, benhcotsong, benhvemat, bietboi, cannang, chadantoc, chieucao, chisobmi, cocapgao

### Thongtindoingucanbocsgdcapmamnonththcsthpttx
- Domain: Reference / Other
- Physical coverage: thongtindoingucanbocsgdcapmamnonththcsthpttx (core), thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn (person-nationality subtype), thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai (person-nationality subtype), thongtindoingucanbocsgdcapmamnonththcsthpttx_monday (core), thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem (core), thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu (core)
- Key business attributes: cochuyentrachdoandoi, codangvien, coday1buoi, coday2buoi, codaylopkhuyettat, codoanvien, coquantuyen, cotaphuankynangsong, danhhieuptcaonhat, email

### Thongtinkhenthuonggiaoviencapmnththcsthpttx
- Domain: Reward & Discipline
- Physical coverage: thongtinkhenthuonggiaoviencapmnththcsthpttx (core)
- Key business attributes: capkhenthuong, magiaovien, matruong, nam, ngaykhenthuong, noidungkhenthuong, soquyetdinh, makhenthuonggv, maloaikhenthuong, manhomcaphoc

### Thongtinkyluatgiaoviencapmnththcsthpttx
- Domain: Reward & Discipline
- Physical coverage: thongtinkyluatgiaoviencapmnththcsthpttx (core)
- Key business attributes: lydo, magiaovien, matruong, ngaykyluat, soquyetdinh, capkyluat, loaikyluat, makyluatgv, manhomcaphoc, keythongtinkyluatgiaoviencapmnththcsthpttx

### Quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx
- Domain: Staff & Lecturer
- Physical coverage: quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx (core)
- Key business attributes: chuyennganh, hinhthucdaotao, magiaovien, manhomchuyennganh, matruong, tentruong, thoigiandaotao_denngay, thoigiandaotao_tungay, vanbangchungchi_ma, vanbangchungchi_ten

### Ketquahoctapththcsthpttx
- Domain: Reference / Other
- Physical coverage: ketquahoctapththcsthpttx (core), ketquahoctapththcsthpttx_nguoivn (person-nationality subtype), ketquahoctapththcsthpttx_cogndannuocngoai (core), ketquahoctapththcsthpttx_khenthuong (core), ketquahoctapththcsthpttx_kyluat (core), ketquahoctapththcsthpttx_diemmon (core)
- Key business attributes: coduxettotnghiep, colenlop, corenluyenlai, diemtongket, hocky, mahocsinh, makhoi, malop, matruong, nhanxet

### Thongtinlophoctieuhoc
- Domain: Reference / Other
- Physical coverage: thongtinlophoctieuhoc (core)
- Key business attributes: cocapnhatlopghep, cocohocsinhhocnghe, codaidienchamehslop, codaidienchamehstruong, coday2buoingay, coduthietbihoctoan, coduthietbihoctv, cohoc5buoituan, cohoc6den8buoituan, cohoc9den10buoituan

### Cosovatchatphonghoctieuhoc
- Domain: Institution & Organization
- Physical coverage: cosovatchatphonghoctieuhoc (core)
- Key business attributes: dientich, dientichcap4, dientichduoicap4, dientichtrencap4, mabaocao, madiemtruong, matruong, noidungtieuchi, soluong, soluongcap4

### Thongtinlophocthcsthpt
- Domain: Reference / Other
- Physical coverage: thongtinlophocthcsthpt (core), thongtinlophocthcsthpt_monhoc (core)
- Key business attributes: colopchuyen, comacapnhatlopghep, comadaidienchamehslop, comadaidienchamehstruong, comaday2buoingay, comahoc5buoituan, comahocsinhhocnghe, comahskhuyettat, comalopbantru, comalopghep

### Cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr
- Domain: Institution & Organization
- Physical coverage: cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr (core)
- Key business attributes: mavungkhokhan, keycosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvaca

### Decimal 20
- Domain: Reference / Other
- Physical coverage: decimal__20 (core)
- Key business attributes: x

### Thongtinlophocgdtx
- Domain: Reference / Other
- Physical coverage: thongtinlophocgdtx (core), thongtinlophocgdtx_monhoc (core)
- Key business attributes: codaidienchamehslop, codaidienchamehstruong, colopcohskhuyettat, magiaoviencn, malop, matrungtam, tenlop, hinhthuchoctap, makhoi, makieulop

### Thongtinsohocbasotieuhoc
- Domain: Reference / Other
- Physical coverage: thongtinsohocbasotieuhoc (core), thongtinsohocbasotieuhoc_quatrinhhoctap (core), thongtinsohocbasotieuhoc_dsbangdiem (core)
- Key business attributes: chucvugiamhieu, cokhuyettatkhongdanhgia, dahthanhctrinhlophoc, dahthanhctrinhtieuhoc, diadanhphathanh, doituongchinhsach, duoclenlop, gioitinh, hotencha, hotenme

### Decimal 18.4
- Domain: Reference / Other
- Physical coverage: decimal__18.4 (core)
- Key business attributes: x, x_2

### Thongtinsohocbasothcsthpt
- Domain: Reference / Other
- Physical coverage: thongtinsohocbasothcsthpt (core), thongtinsohocbasothcsthpt_quatrinhhoctap (core), thongtinsohocbasothcsthpt_chungchi (core), thongtinsohocbasothcsthpt_bangdiem (core)
- Key business attributes: canam, chucvugiamhieu, cokhuyettatkhongdanhgia, diadanhphathanh, doituongchinhsach, duoclenlop, gioitinh, hocky1, hocky2, hotencha

### Higher Education Institution
- Domain: Institution & Organization
- Physical coverage: cosogiaoducdaihoc (core)
- Key business attributes: coquanqltructiep, daotaodubidaihoc, daotaogiaovientrinhdocaodang, daotaogiaovientrinhdotrungcap, daotaotheotinchi, daotaotrinhdodaihoc, daotaotrinhdothacsi, daotaotrinhdotiensi, diachi_diachichitiet, email_thongtinlienhe

### Organization Unit
- Domain: Institution & Organization
- Physical coverage: thongtincocautochuc (core)
- Key business attributes: loaiphongban, maddtc, maphongban, maphongbancha, quyetdinhthanhlap_ngayqd, quyetdinhthanhlap_soqd, tenphongban, trangthaihdtc, macosodaotao, keythongtincocautochuc

### Building
- Domain: Institution & Organization
- Physical coverage: thongtintoanha (core)
- Key business attributes: diachichitiet, dientichxaydung, hinhthucsohuu, matoanha, nambdsudung, ngaychuyentrangthai, phuongxa, sotang, tentoanha, tinhtp

### Land / Facility Asset
- Domain: Institution & Organization
- Physical coverage: csvcvatrangthietbidatdai (core), csvcvatrangthietbidatdai_doituongsohuu_nguoivn (person-nationality subtype), csvcvatrangthietbidatdai_doituongsohuu_dinhdanhtochuc (ownership subtype)
- Key business attributes: diachichitiet, dientichdasudung, dientichdat, hinhthucsohuu, magcn, minhchungquyensohuu, mucdichsudung, nambdsudung, ngaychuyentrangthai, phuongxa

### Teaching Room / Hall
- Domain: Institution & Organization
- Physical coverage: phonghocgiangduongvahoitruong (core)
- Key business attributes: chongoi, diachichitiet, dientich, hinhthucsohuu, loaidean, loaiphonghoc, maphonghocgdht, namsudung, ngaychuyentrangthai, phanloai

### Learner
- Domain: Learner Profile
- Physical coverage: ttchunghocvien (core), ttchunghocvien_nguoivn (person-nationality subtype), ttchunghocvien_nguoivn_giaytodinhdanhcn (identity-document subtype), ttchunghocvien_congdannuocngoai (person-nationality subtype), ttchunghocvien_congdannuocngoai_giaytodinhdanhnn (identity-document subtype)
- Key business attributes: email, hotencha, hotenme, hotennguoigiamho, loaikhuyettat, macosodaotao, mahocvien, masobhxh, ngayvaodang, ngayvaodangchinhthuc

### Postgraduate Study Record
- Domain: Learning & Study
- Physical coverage: thongtinhoctapsvdh (core), thongtinhoctapsvdh_nguoivn (person-nationality subtype), thongtinhoctapsvdh_congdannuocngoai (person-nationality subtype), ThongTinHocTapSVDH_QuyetDinhThoiHocBaoLuu (decision detail)
- Key business attributes: bangtotnghieplienthong, chuongtrinhdaotao, coquanqd, coquanqd_2, coquanqd_3, coquanqd_4, dangonoitru, daotaoden, daotaotu, doituongdauvao

### Credential / Certificate
- Domain: Credential & Certificate
- Physical coverage: VanBangChungChi (core), VanBangChungChi_ThongTinHieuChinh (change/history detail)
- Key business attributes: chucvu, donvicap, hinhthucdaotao, hoidongthi, hovaten, khoathi, madinhdanhvbcc, mahocvien, matruong, namsinh

### Reward
- Domain: Reward & Discipline
- Physical coverage: KhenThuong (core), KhenThuong_NguoiVN (person-nationality subtype), KhenThuong_CongDanNuocNgoai (person-nationality subtype)
- Key business attributes: doituong, namkhenthuong, noidungkhenthuong, quyetdinhkhenthuong_ngayqd, quyetdinhkhenthuong_soqd, thanhtichkhenthuong, capkhenthuong, hinhthuckhenthuong, idthongtinhoctap, loaikhenthuong

### Discipline
- Domain: Reward & Discipline
- Physical coverage: KyLuat (core), KyLuat_NguoiVN (person-nationality subtype), KyLuat_CongDanNuocNgoai (person-nationality subtype)
- Key business attributes: capkyluat, denngay, doituong, hanhvikyluat, lydokyluat, macosodaotao, maloaikyluat, namkyluat, quyetdinhkyluat_capquyetdinh, quyetdinhkyluat_ngayqd

### Staff / Lecturer
- Domain: Staff & Lecturer
- Physical coverage: ThongTinCanBoGiangVien (core), ThongTinCanBoGiangVien_NguoiVN (person-nationality subtype), ThongTinCanBoGiangVien_NguoiVN_GiayToDinhDanhCN (identity-document subtype), ThongTinCanBoGiangVien_CongDanNuocNgoai (person-nationality subtype), ThongTinCanBoGiangVien_CongDanNuocNgoai_GiayToDinhDanhNN (identity-document subtype)
- Key business attributes: bacsiduocsicki, bacsiduocsickii, ccsuphamgiangvien, cholamviecrieng, chuyenmondaotao, cqcongtac, email, lacongchuc, lavienchuc, macanbo

### Work Unit Assignment
- Domain: Staff & Lecturer
- Physical coverage: PhongBanDonViCongTac (core), PhongBanDonViCongTac_NguoiVN (person-nationality subtype), PhongBanDonViCongTac_CongDanNuocNgoai (person-nationality subtype)
- Key business attributes: denngay, donvichinh, donvigiangday, ngayqd, soqd, tungay, chucvucongtac, hinhthucbonhiem, macosodaotao, maphongban

### Teaching / Work History
- Domain: Staff & Lecturer
- Physical coverage: QuaTrinhCongTacCuaCanBoGiangVien (core), QuaTrinhCongTacCuaCanBoGiangVien_NguoiVN (person-nationality subtype), QuaTrinhCongTacCuaCanBoGiangVien_CongDanNuocNgoai (person-nationality subtype)
- Key business attributes: donvithinhgiang, nganhchinh, macosodaotao, manganhgiangday, trinhdogiangday, keyquatrinhcongtaccuacanbogiangvien, hovaten, namsinh, ngaythangnamsinh, sodinhdanh

### Staff Education / Training History
- Domain: Staff & Lecturer
- Physical coverage: QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien (core), QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_NguoiVN (person-nationality subtype), QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_CongDanNuocNgoai (person-nationality subtype)
- Key business attributes: cosodaotao, namtn, quocgiadaotao, thoigianbddaotao, thoigianktdaotao, loaihinhdaotao, macosodaotao, nganhdaotao, trinhdodaotao, keyquatrinhdaotaoboiduongcuacanbogiangvien

### Training Major
- Domain: Learning & Study
- Physical coverage: DanhSachNganhDaoTao (core)
- Key business attributes: coquanbanhanh, hinhthucdaotaocn, nambddaotao, namdtgannhat, nguoiky, qddoitennganh_ngayqd, qddoitennganh_spqd, qdmonganh_ngayqd, qdmonganh_soqd, quyetdinhtuchu

### Training Program
- Domain: Learning & Study
- Physical coverage: ChuongTrinhDaoTao (core)
- Key business attributes: chuandaura, chuandaurangoaingu, chuandauratinhoc, diachichitiet, donvithuchien, dsloaiccchapthuan_loaiccchapthuan, hocphinn, hocphivn, namtuyensinh, ngaybanhanhdaura

## Conceptual Relationships
- `thongtinhocsinhcapmnththcsthpttx_nguoivn.keythongtinhocsinhcapmnththcsthpttx` -> `thongtinhocsinhcapmnththcsthpttx.keythongtinhocsinhcapmnththcsthpttx`
- `thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn.keythongtinhocsinhcapmnththcsthpttx_nguoivn` -> `thongtinhocsinhcapmnththcsthpttx_nguoivn.keythongtinhocsinhcapmnththcsthpttx_nguoivn`
- `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai.keythongtinhocsinhcapmnththcsthpttx` -> `thongtinhocsinhcapmnththcsthpttx.keythongtinhocsinhcapmnththcsthpttx`
- `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhdanh.keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai` -> `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai.keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai`
- `thongtinhocsinhcapmnththcsthpttx_thongtincha.keythongtinhocsinhcapmnththcsthpttx` -> `thongtinhocsinhcapmnththcsthpttx.keythongtinhocsinhcapmnththcsthpttx`
- `thongtinhocsinhcapmnththcsthpttx_thongtinme.keythongtinhocsinhcapmnththcsthpttx` -> `thongtinhocsinhcapmnththcsthpttx.keythongtinhocsinhcapmnththcsthpttx`
- `thongtinhocsinhcapmnththcsthpttx_nguoidodau.keythongtinhocsinhcapmnththcsthpttx` -> `thongtinhocsinhcapmnththcsthpttx.keythongtinhocsinhcapmnththcsthpttx`
- `thongtinhocsinhcapmnththcsthpttx_khenthuong.keythongtinhocsinhcapmnththcsthpttx` -> `thongtinhocsinhcapmnththcsthpttx.keythongtinhocsinhcapmnththcsthpttx`
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn.keythongtindoingucanbocsgdcapmamnonththcsthpttx` -> `thongtindoingucanbocsgdcapmamnonththcsthpttx.keythongtindoingucanbocsgdcapmamnonththcsthpttx`
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai.keythongtindoingucanbocsgdcapmamnonththcsthpttx` -> `thongtindoingucanbocsgdcapmamnonththcsthpttx.keythongtindoingucanbocsgdcapmamnonththcsthpttx`
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_monday.keythongtindoingucanbocsgdcapmamnonththcsthpttx` -> `thongtindoingucanbocsgdcapmamnonththcsthpttx.keythongtindoingucanbocsgdcapmamnonththcsthpttx`
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem.keythongtindoingucanbocsgdcapmamnonththcsthpttx` -> `thongtindoingucanbocsgdcapmamnonththcsthpttx.keythongtindoingucanbocsgdcapmamnonththcsthpttx`
- `thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu.keythongtindoingucanbocsgdcapmamnonththcsthpttx` -> `thongtindoingucanbocsgdcapmamnonththcsthpttx.keythongtindoingucanbocsgdcapmamnonththcsthpttx`
- `ketquahoctapththcsthpttx_nguoivn.keyketquahoctapththcsthpttx` -> `ketquahoctapththcsthpttx.keyketquahoctapththcsthpttx`
- `ketquahoctapththcsthpttx_cogndannuocngoai.keyketquahoctapththcsthpttx` -> `ketquahoctapththcsthpttx.keyketquahoctapththcsthpttx`
- `ketquahoctapththcsthpttx_khenthuong.keyketquahoctapththcsthpttx` -> `ketquahoctapththcsthpttx.keyketquahoctapththcsthpttx`
- `ketquahoctapththcsthpttx_kyluat.keyketquahoctapththcsthpttx` -> `ketquahoctapththcsthpttx.keyketquahoctapththcsthpttx`
- `ketquahoctapththcsthpttx_diemmon.keyketquahoctapththcsthpttx` -> `ketquahoctapththcsthpttx.keyketquahoctapththcsthpttx`
- `thongtinlophocgdtx_monhoc.keythongtinlophocgdtx` -> `thongtinlophocgdtx.keythongtinlophocgdtx`
- `thongtinsohocbasotieuhoc_quatrinhhoctap.keythongtinsohocbasotieuhoc` -> `thongtinsohocbasotieuhoc.keythongtinsohocbasotieuhoc`
- `thongtinsohocbasotieuhoc_dsbangdiem.keythongtinsohocbasotieuhoc` -> `thongtinsohocbasotieuhoc.keythongtinsohocbasotieuhoc`
- `thongtinsohocbasothcsthpt_quatrinhhoctap.keythongtinsohocbasothcsthpt` -> `thongtinsohocbasothcsthpt.keythongtinsohocbasothcsthpt`
- `thongtinsohocbasothcsthpt_chungchi.keythongtinsohocbasothcsthpt` -> `thongtinsohocbasothcsthpt.keythongtinsohocbasothcsthpt`
- `thongtinsohocbasothcsthpt_bangdiem.keythongtinsohocbasothcsthpt` -> `thongtinsohocbasothcsthpt.keythongtinsohocbasothcsthpt`
- `thongtincocautochuc.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `thongtintoanha.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `csvcvatrangthietbidatdai.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `csvcvatrangthietbidatdai_doituongsohuu_nguoivn.keycsvcvatrangthietbi` -> `csvcvatrangthietbidatdai.keycsvcvatrangthietbi`
- `csvcvatrangthietbidatdai_doituongsohuu_dinhdanhtochuc.keycsvcvatrangthietbi` -> `csvcvatrangthietbidatdai.keycsvcvatrangthietbi`
- `phonghocgiangduongvahoitruong.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `ttchunghocvien_nguoivn.keyttchunghocvien` -> `ttchunghocvien.keyttchunghocvien`
- `ttchunghocvien_nguoivn_giaytodinhdanhcn.keyttchunghocviennguoivn` -> `ttchunghocvien_nguoivn.keyttchunghocviennguoivn`
- `ttchunghocvien_congdannuocngoai.keyttchunghocvien` -> `ttchunghocvien.keyttchunghocvien`
- `ttchunghocvien_congdannuocngoai_giaytodinhdanhnn.keyttchunghocviencongdannuocngoai` -> `ttchunghocvien_congdannuocngoai.keyttchunghocviencongdannuocngoai`
- `thongtinhoctapsvdh_nguoivn.keythongtinhoctapsvdh` -> `thongtinhoctapsvdh.keythongtinhoctapsvdh`
- `thongtinhoctapsvdh_congdannuocngoai.keythongtinhoctapsvdh` -> `thongtinhoctapsvdh.keythongtinhoctapsvdh`
- `ThongTinHocTapSVDH_QuyetDinhThoiHocBaoLuu.keythongtinhoctapsvdh` -> `thongtinhoctapsvdh.keythongtinhoctapsvdh`
- `VanBangChungChi_ThongTinHieuChinh.keyvanbangchungchi` -> `VanBangChungChi.keyvanbangchungchi`
- `KhenThuong.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `KhenThuong_NguoiVN.keykhenthuong` -> `KhenThuong.keykhenthuong`
- `KhenThuong_CongDanNuocNgoai.keykhenthuong` -> `KhenThuong.keykhenthuong`
- `KyLuat_NguoiVN.keykyluat` -> `KyLuat.keykyluat`
- `KyLuat_CongDanNuocNgoai.keykyluat` -> `KyLuat.keykyluat`
- `ThongTinCanBoGiangVien.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `ThongTinCanBoGiangVien_NguoiVN.keythongtincanbogiangvien` -> `ThongTinCanBoGiangVien.keythongtincanbogiangvien`
- `ThongTinCanBoGiangVien_NguoiVN_GiayToDinhDanhCN.keythongtincanbogiangvien` -> `ThongTinCanBoGiangVien.keythongtincanbogiangvien`
- `ThongTinCanBoGiangVien_CongDanNuocNgoai.keythongtincanbogiangvien` -> `ThongTinCanBoGiangVien.keythongtincanbogiangvien`
- `ThongTinCanBoGiangVien_CongDanNuocNgoai_GiayToDinhDanhNN.keythongtincanbogiangvien` -> `ThongTinCanBoGiangVien.keythongtincanbogiangvien`
- `PhongBanDonViCongTac.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `PhongBanDonViCongTac_NguoiVN.keyphongbandonvicongtac` -> `PhongBanDonViCongTac.keyphongbandonvicongtac`
- `PhongBanDonViCongTac_CongDanNuocNgoai.keyphongbandonvicongtac` -> `PhongBanDonViCongTac.keyphongbandonvicongtac`
- `QuaTrinhCongTacCuaCanBoGiangVien.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `QuaTrinhCongTacCuaCanBoGiangVien_NguoiVN.keyquatrinhcongtaccuacanbogiangvien` -> `QuaTrinhCongTacCuaCanBoGiangVien.keyquatrinhcongtaccuacanbogiangvien`
- `QuaTrinhCongTacCuaCanBoGiangVien_CongDanNuocNgoai.keyquatrinhcongtaccuacanbogiangvien` -> `QuaTrinhCongTacCuaCanBoGiangVien.keyquatrinhcongtaccuacanbogiangvien`
- `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_NguoiVN.keyquatrinhdaotaoboiduongcuacanbogiangvien` -> `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien.keyquatrinhdaotaoboiduongcuacanbogiangvien`
- `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_CongDanNuocNgoai.keyquatrinhdaotaoboiduongcuacanbogiangvien` -> `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien.keyquatrinhdaotaoboiduongcuacanbogiangvien`
- `DanhSachNganhDaoTao.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `ChuongTrinhDaoTao.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao`
- `ttchunghocvien.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao` (inferred-business-key)
- `thongtinhoctapsvdh.mahocvien` -> `ttchunghocvien.mahocvien` (inferred-business-key)
- `VanBangChungChi.mahocvien` -> `ttchunghocvien.mahocvien` (inferred-business-key)
- `KyLuat.macosodaotao` -> `cosogiaoducdaihoc.macosodaotao` (inferred-business-key)

## Human Approval Checklist
- Confirm unresolved lookup/reference FK targets such as province, commune, nationality, gender, religion, major, training level.
- Confirm whether technical audit columns should be excluded from downstream conceptual diagrams.
- Confirm naming language: English entity names vs Vietnamese official terms.