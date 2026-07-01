# Business Glossary

## Thongtindiemtruongchinhcapmnththcsthpt
- Domain: Reference / Other
- Source tables: `thongtindiemtruongchinhcapmnththcsthpt`

- `CoChatLuongToiThieu`: Có đạt chất lượng tối thiểu 1 - Có 0 - Không Nhóm cấp học mầm non không có thông tin này
- `CoChuongTrinhGiaoDucGioiTinh`: Có chương trình giáo dục cơ bản 1 - Có 0 - Không
- `CoChuongTrinhGiaoDucVeSinhDoiTay`: Có chương trình giáo dục vệ sinh đôi tay  1 - Có 0 - Không
- `CoCongTrinhVeSinhTheoGioiTinh`: Có công trình vệ sinh 1 - Có 0 - Không
- `CoDay2BuoiNgay`: Có dạy 2 buổi/ngày  1 - Có 0 - Không
- `CoDayNghePhoThong`: Có dạy nghề phổ thông 1 - Có 0 - Không Nhóm cấp học mầm non không có thông tin này
- `CoDienLuoi`: Có điện lưới 1 - Có 0 - Không
- `CoHaTangTiepCanHocSinhKhuyetTat`: Có hạ tầng tiếp cận học sinh khuyết tật 1 - Có 0 - Không Nhóm cấp học mầm non không có thông tin này
- `CoHocSinhBanTru`: Có học sinh bán trú  1 - Có 0 - Không
- `CoHocSinhKhuyetTat`: Có học sinh khuyết tật  1 - Có 0 - Không
- `CoHocSinhNoiTru`: Có học sinh nội trú 1 - Có 0 - Không Nhóm cấp học mầm non không có thông tin này
- `CoKyNangSong`: Có học kỹ năng sống 1 - Có 0 - Không Nhóm cấp học mầm non không có thông tin này

## Thongtindiemtruongcapmnththcsthpttx
- Domain: Reference / Other
- Source tables: `thongtindiemtruongcapmnththcsthpttx`

- `diachi_diachichitiet`: Địa chỉ chi tiết
- `dientich`: Diện tích (m2)
- `kcdentruongchinh`: Khoảng cách đến trường chính (km)
- `madiemtruong`: Mã điểm trường
- `manhomcaphoc`: Mã nhóm cấp học theo danh mục của bộ ngành - 01: Mầm non - 02: Tiểu học - 03: Trung học cơ sở - 04: Trung học phổ thông - 05: Thường xuyên
- `matruong`: Mã điểm trường chính/mã trung tâm thường xuyên Tham chiếu thông tin điểm trưởng chính cấp mầm non
- `phuongtiendilai`: Phương tiện có thể đi lại
- `sodienthoai`: Số điện thoại
- `tendiemtruong`: Tên điểm trường
- `diachi_mahuyen` [FK]: Mã quận, huyện, thị xã, thành phố theo quy định tại phụ lục của tài liệu
- `diachi_matinh` [FK]: Mã tỉnh, thành phố trực thuộc trung ương theo quy định tại phụ lục của tài liệu
- `diachi_maxa` [FK]: Mã xã, phường, thị trấn theo quy định tại phụ lục của tài liệu

## Lopmamnon
- Domain: Reference / Other
- Source tables: `lopmamnon`

- `capnhatlopghep`: Có cập nhật lớp ghép 0 - Không 1 - Có
- `coctcsgd`: Là lớp có chương trình chăm sóc giáo dục 0 - Không 1 - Có
- `coctgdmnmoi`: Là lớp có chương trình mầm non mới 0 - Không 1 - Có
- `coday2buoingay`: Có dạy 2 buổi/ngày 0 - Không 1 - Có
- `cotrekhuyettat`: Là lớp có trẻ khuyết tật 0 - Không 1 - Có
- `ghep2tuoi`: Là lớp ghép 2 tuổi 0 - Không 1 - Có
- `ghep3tuoi`: Là lớp ghép 3 tuổi 0 - Không 1 - Có
- `ghep4tuoi`: Là lớp ghép 4 tuổi 0 - Không 1 - Có
- `lopbantru`: Là lớp bán trú 0 - Không 1 - Có
- `lopghep`: Là lớp ghép 0 - Không 1 - Có
- `madiemtruong`: Mã điểm trường
- `magiaoviencn`: Mã giáo viên chủ nhiệm Tham chiếu thông tin Giáo viên chủ nhiệm

## Thongtinhocsinhcapmnththcsthpttx
- Domain: Reference / Other
- Source tables: `thongtinhocsinhcapmnththcsthpttx`, `thongtinhocsinhcapmnththcsthpttx_nguoivn`, `thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn`, `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai`, `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhdanh`, `thongtinhocsinhcapmnththcsthpttx_thongtincha`, `thongtinhocsinhcapmnththcsthpttx_thongtinme`, `thongtinhocsinhcapmnththcsthpttx_nguoidodau`, `thongtinhocsinhcapmnththcsthpttx_khenthuong`

- `benhbamsinh`: Các bệnh bẩm sinh
- `benhcoixuong`: Bệnh còi xương
- `benhcotsong`: Các bệnh về cột sống
- `benhvemat`: Các bệnh về mắt
- `bietboi`: Có biết bơi không 0 - Không 1 - Có
- `cannang`: Cân nặng
- `chadantoc`: Có cha dân tộc không 0 - Không 1 - Có
- `chieucao`: Chiều cao
- `chisobmi`: Chỉ số (BMI)
- `cocapgao`: Cấp gạo 0 - Không 1 - Có Nhóm cấp học mầm non không có thông tin này
- `cocaptienhangthang`: Cấp tiền hàng tháng 0 - Không 1 - Có Nhóm cấp học mầm non không có thông tin này
- `codoanvien`: Là đoàn viên 0 - Không 1 - Có Nhóm cấp học mầm non không có thông tin này

## Thongtindoingucanbocsgdcapmamnonththcsthpttx
- Domain: Reference / Other
- Source tables: `thongtindoingucanbocsgdcapmamnonththcsthpttx`, `thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn`, `thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai`, `thongtindoingucanbocsgdcapmamnonththcsthpttx_monday`, `thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem`, `thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu`

- `cochuyentrachdoandoi`: Có chuyên trách đoàn đội, nhận 2 giá trị: 0: Không 1: Có
- `codangvien`: Là đảng viên không 0: Không 1: Có
- `coday1buoi`: Có dạy 1 buổi/ ngày, nhận 2 giá trị: 0: Không 1: Có
- `coday2buoi`: Có dạy 2 buổi/ ngày, nhận 2 giá trị: 0: Không 1: Có
- `codaylopkhuyettat`: Có dạy lớp khuyết tật, nhận 2 giá trị: 0: Không 1: Có
- `codoanvien`: Là đoàn viên không 0: Không 1: Có
- `coquantuyen`: Cơ quan tuyển dụng
- `cotaphuankynangsong`: Có được tập huấn kỹ năng sống, nhận 2 giá trị: 0: Không 1: Có
- `danhhieuptcaonhat`: Danh hiệu được phong tặng cao nhất
- `email`: Email
- `magiaovien`: Mã giáo viên
- `masobhxh`: Mã sổ bảo hiểm xã hội

## Thongtinkhenthuonggiaoviencapmnththcsthpttx
- Domain: Reward & Discipline
- Source tables: `thongtinkhenthuonggiaoviencapmnththcsthpttx`

- `capkhenthuong`: Cấp khen thưởng giáo viên theo danh mục của bộ ngành
- `magiaovien`: Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ
- `matruong`: Mã trường/Mã trung tâm. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT
- `nam`: Năm quyết định. Định dạng YYYY
- `ngaykhenthuong`: Ngày khen thưởng. Định dạng YYYY-MM-DD
- `noidungkhenthuong`: Nội dung khen thưởng giao viên
- `soquyetdinh`: Số quyết định
- `makhenthuonggv` [FK]: Mã khen thưởng giáo viên theo danh mục của bộ ngành
- `maloaikhenthuong` [FK]: Mã Loại khen thưởng giáo viên theo danh mục của bộ ngành
- `manhomcaphoc` [FK]: Mã nhóm cấp học theo danh mục của bộ ngành - 01: Mầm non - 02: Tiểu học - 03: Trung học cơ sở - 04: Trung học phổ thông - 05: Thường xuyên
- `keythongtinkhenthuonggiaoviencapmnththcsthpttx` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống

## Thongtinkyluatgiaoviencapmnththcsthpttx
- Domain: Reward & Discipline
- Source tables: `thongtinkyluatgiaoviencapmnththcsthpttx`

- `lydo`: Lý do
- `magiaovien`: Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ
- `matruong`: Mã trường/Mã trung tâm. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT
- `ngaykyluat`: Ngày kỷ luật. Định dạng YYYY-MM-DD
- `soquyetdinh`: Số quyết định
- `capkyluat` [FK]: Cấp kỷ luật theo danh mục của bộ ngành
- `loaikyluat` [FK]: Mã Loại kỷ luật theo danh mục của bộ ngành
- `makyluatgv` [FK]: Mã kỷ luật giáo viên theo danh mục của bộ ngành
- `manhomcaphoc` [FK]: Mã nhóm cấp học theo danh mục của bộ ngành - 01: Mầm non - 02: Tiểu học - 03: Trung học cơ sở - 04: Trung học phổ thông - 05: Thường xuyên
- `keythongtinkyluatgiaoviencapmnththcsthpttx` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống

## Quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx
- Domain: Staff & Lecturer
- Source tables: `quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx`

- `chuyennganh`: Chuyên ngành đào tạo
- `hinhthucdaotao`: Mã hình thức đào tạo theo danh mục
- `magiaovien`: Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ
- `manhomchuyennganh`: Mã nhóm chuyên ngành theo danh mục của bộ ngành
- `matruong`: Mã trường. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT
- `tentruong`: Tên trường
- `thoigiandaotao_denngay`: Đến ngày tháng năm. Định dạng YYYY-MM-DD
- `thoigiandaotao_tungay`: Từ ngày tháng năm. Định dạng YYYY-MM-DD
- `vanbangchungchi_ma`: Mã văn bản chứng chỉ
- `vanbangchungchi_ten`: Tên văn bản chứng chỉ
- `manhomcaphoc` [FK]: Mã nhóm cấp học theo danh mục của bộ ngành - 01: Mầm non - 02: Tiểu học - 03: Trung học cơ sở - 04: Trung học phổ thông - 05: Thường xuyên
- `keyquatrinhdaotaoboiduonggiaoviencapmnththcsthpttx` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống

## Ketquahoctapththcsthpttx
- Domain: Reference / Other
- Source tables: `ketquahoctapththcsthpttx`, `ketquahoctapththcsthpttx_nguoivn`, `ketquahoctapththcsthpttx_cogndannuocngoai`, `ketquahoctapththcsthpttx_khenthuong`, `ketquahoctapththcsthpttx_kyluat`, `ketquahoctapththcsthpttx_diemmon`

- `coduxettotnghiep`: Được dự xét tốt nghiệp 0 - Không 1 - Có
- `colenlop`: Được lên lớp 0 - Không 1 - Có
- `corenluyenlai`: Rèn luyện lại 0 - Không 1 - Có
- `diemtongket`: Điểm tổng kết
- `hocky`: Học kỳ
- `mahocsinh`: Mã học sinh. Tham chiếu đến dữ liệu Học sinh Tiểu học - THCS - THPT
- `makhoi`: Tên trường
- `malop`: Mã lớp
- `matruong`: Mã trường. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT
- `nhanxet`: Nhận xét
- `songaynghi`: Số ngày nghỉ
- `totnghiepcap`: Tốt nghiệp cấp học

## Thongtinlophoctieuhoc
- Domain: Reference / Other
- Source tables: `thongtinlophoctieuhoc`

- `cocapnhatlopghep`: Có cập nhật lớp ghép 0 - Không 1 - Có
- `cocohocsinhhocnghe`: Có học sinh học nghề 0 - Không 1 - Có
- `codaidienchamehslop`: Có đại diện cha mẹ học sinh lớp 0 - Không 1 - Có
- `codaidienchamehstruong`: Có đại diện cha mẹ học sinh trường 0 - Không 1 - Có
- `coday2buoingay`: Dạy 2 buổi / ngày 0 - Không 1 - Có
- `coduthietbihoctoan`: Đủ thiết bị dạy học - Toán 0 - Không 1 - Có
- `coduthietbihoctv`: Đủ thiết bị dạy học - Tiếng Việt 0 - Không 1 - Có
- `cohoc5buoituan`: Là lớp học 5 buổi / tuần 0 - Không 1 - Có
- `cohoc6den8buoituan`: Là lớp học 6-8 buổi / tuần 0 - Không 1 - Có
- `cohoc9den10buoituan`: Là lớp học 9-10 buổi / tuần 0 - Không 1 - Có
- `colopbantru`: Là lớp bán trú 0 - Không 1 - Có
- `colopchuyenbiet`: Là lớp chuyên biệt 0 - Không 1 - Có

## Cosovatchatphonghoctieuhoc
- Domain: Institution & Organization
- Source tables: `cosovatchatphonghoctieuhoc`

- `dientich`: Diện tích phòng học/công trình
- `dientichcap4`: Diện tích phòng học/công trình cấp 4
- `dientichduoicap4`: Diện tích phòng học/công trình dưới cấp 4
- `dientichtrencap4`: Diện tích phòng học/công trình trên cấp 4
- `mabaocao`: Mã báo cáo
- `madiemtruong`: Mã điểm trường. Tham chiếu đến dữ liệu điểm trường
- `matruong`: Mã trường tiểu học. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT
- `noidungtieuchi`: Nội dung tiêu chí
- `soluong`: Số lượng phòng học/công trình
- `soluongcap4`: Số lượng phòng học/công trình cấp 4
- `soluongduoicap4`: Số lượng phòng học/công trình dưới cấp 4
- `soluongtrencap4`: Số lượng phòng học/công trình trên cấp 4

## Thongtinlophocthcsthpt
- Domain: Reference / Other
- Source tables: `thongtinlophocthcsthpt`, `thongtinlophocthcsthpt_monhoc`

- `colopchuyen`: Là lớp chuyện 0 - Không 1 - Có Nhóm cấp học THCS không có thông tin này
- `comacapnhatlopghep`: Có cập nhật lớp ghép 0 - Không 1 - Có
- `comadaidienchamehslop`: Có đại diện cha mẹ học sinh lớp 0 - Không 1 - Có
- `comadaidienchamehstruong`: Có đại diện cha mẹ học sinh trường 0 - Không 1 - Có
- `comaday2buoingay`: Dạy 2 buổi / ngày 0 - Không 1 - Có
- `comahoc5buoituan`: Là lớp học 5 buổi / tuần 0 - Không 1 - Có
- `comahocsinhhocnghe`: Có học sinh học nghề 0 - Không 1 - Có
- `comahskhuyettat`: Lớp có học sinh khuyết tật 0 - Không 1 - Có
- `comalopbantru`: Là lớp bán trú 0 - Không 1 - Có Nhóm cấp học THPT không có thông tin này
- `comalopghep`: Là lớp ghép 0 - Không 1 - Có
- `madiemtruong`: Mã điểm trường. Tham chiếu đến dữ liệu Danh sách điểm trường
- `magiaoviencn`: Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ

## Cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr
- Domain: Institution & Organization
- Source tables: `cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr`

- `mavungkhokhan`: Mã vùng khó khăn theo quy định tại Quyết định số 4998/QĐBGDĐT
- `keycosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvaca` [FK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống

## Decimal 20
- Domain: Reference / Other
- Source tables: `decimal__20`

- `x`: TBD

## Thongtinlophocgdtx
- Domain: Reference / Other
- Source tables: `thongtinlophocgdtx`, `thongtinlophocgdtx_monhoc`

- `codaidienchamehslop`: Có đại diện cha mẹ học sinh lớp 0 - Không 1 - Có
- `codaidienchamehstruong`: Có đại diện cha mẹ học sinh trường 0 - Không 1 - Có
- `colopcohskhuyettat`: Lớp có học sinh khuyết tật 0 - Không 1 - Có
- `magiaoviencn`: Mã giáo viên chủ nhiệm. Tham chiếu đến dữ liệu Đội ngũ cán bộ
- `malop`: Mã lớp
- `matrungtam`: Mã trung tâm. Tham chiếu đến dữ liệu Cơ sở giáo dục thường xuyên
- `tenlop`: Tên lớp
- `hinhthuchoctap` [FK]: Hình thức học tập theo danh mục quy định tại Quyết định số 4998/QĐBGDĐT
- `makhoi` [FK]: Mã khối theo danh mục của bộ ngành
- `makieulop` [FK]: Mã kiểu lớp theo danh mục của bộ ngành
- `malopdaotaoboiduong` [FK]: Mã lớp đào tạo bồi dưỡng theo danh mục của bộ ngành
- `malophuongnghiepdaynghe` [FK]: Mã lớp hướng nghiệp dạy nghề theo danh mục của bộ ngành

## Thongtinsohocbasotieuhoc
- Domain: Reference / Other
- Source tables: `thongtinsohocbasotieuhoc`, `thongtinsohocbasotieuhoc_quatrinhhoctap`, `thongtinsohocbasotieuhoc_dsbangdiem`

- `chucvugiamhieu`: Chức vụ giám hiệu ký học bạ
- `cokhuyettatkhongdanhgia`: Học sinh khuyết tật không đánh giá: 0: Không 1: Có
- `dahthanhctrinhlophoc`: Đã hoàn thành chương trình lớp học 0 – Không 1 – Có
- `dahthanhctrinhtieuhoc`: Đã hoàn thành chương trình tiểu học 0 – Không 1 – Có
- `diadanhphathanh`: Địa danh phát hành học bạ
- `doituongchinhsach`: Đối tượng chính sách
- `duoclenlop`: Được lên lớp 0 – Không 1 – Có
- `gioitinh`: Giới tính học sinh theo danh mục tại QCVN 109:2017/BTTTT 0 - Chưa có thông tin 1 - Giới tính nam 2 - Giới tính nữ
- `hotencha`: Họ và tên cha
- `hotenme`: Họ và tên mẹ
- `hotennguoigiamho`: Họ và tên người giám hộ
- `hovaten`: Họ và tên học sinh

## Decimal 18.4
- Domain: Reference / Other
- Source tables: `decimal__18.4`

- `x`: TBD
- `x_2`: TBD

## Thongtinsohocbasothcsthpt
- Domain: Reference / Other
- Source tables: `thongtinsohocbasothcsthpt`, `thongtinsohocbasothcsthpt_quatrinhhoctap`, `thongtinsohocbasothcsthpt_chungchi`, `thongtinsohocbasothcsthpt_bangdiem`

- `canam`: Kết quả học tập cả năm theo danh mục: T – Tốt K – Khá Đ – Đạt CĐ – Chưa đạt Tham chiếu đến datatye: data_green_g03_gddt028 trong bảng mã dịch vụ  Không bắt buộc có dữ liệu nếu CoKhuyetTatKhongDanhGia=1
- `chucvugiamhieu`: Chức vụ giám hiệu ký học bạ
- `cokhuyettatkhongdanhgia`: Học sinh khuyết tật không đánh giá: 0: Không 1: Có
- `diadanhphathanh`: Địa danh phát hành học bạ
- `doituongchinhsach`: Đối tượng chính sách
- `duoclenlop`: Được lên lớp: 0- Không 1: Có
- `gioitinh`: Giới tính học sinh theo danh mục tại QCVN 109:2017/BTTTT 0 - Chưa có thông tin 1 - Giới tính nam 2 - Giới tính nữ
- `hocky1`: Kết quả học tập kỳ 1 theo danh mục: T – Tốt K – Khá Đ – Đạt CĐ – Chưa đạt Tham chiếu đến datatye: data_green_g03_gddt028 trong bảng mã dịch vụ  Không bắt buộc có dữ liệu nếu CoKhuyetTatKhongDanhGia=1
- `hocky2`: Kết quả học tập kỳ 2 theo danh mục: T – Tốt K – Khá Đ – Đạt CĐ – Chưa đạt Tham chiếu đến datatye: data_green_g03_gddt028 trong bảng mã dịch vụ  Không bắt buộc có dữ liệu nếu CoKhuyetTatKhongDanhGia=1
- `hotencha`: Họ và tên cha
- `hotenme`: Họ và tên mẹ
- `hotennguoigiamho`: Họ và tên người giám hộ

## Higher Education Institution
- Domain: Institution & Organization
- Source tables: `cosogiaoducdaihoc`

- `coquanqltructiep`: Cơ quan quản lý trực tiếp theo danh mục của bộ ngành
- `daotaodubidaihoc`: Đào tạo Dự bị đại học theo danh mục - 1: Có - 0: Không
- `daotaogiaovientrinhdocaodang`: Đào tạo GV trình độ cao đẳng theo danh mục - 1: Có - 0: Không
- `daotaogiaovientrinhdotrungcap`: Đào tạo GV trình độ trung cấp theo danh mục - 1: Có - 0: Không
- `daotaotheotinchi`: Đào tạo theo tín chỉ theo danh mục - 1: Có - 0: Không
- `daotaotrinhdodaihoc`: Đào tạo trình độ đại học theo danh mục - 1: Có - 0: Không
- `daotaotrinhdothacsi`: Đào tạo trình độ thạc sĩ theo danh mục - 1: Có - 0: Không
- `daotaotrinhdotiensi`: Đào tạo trình độ tiến sĩ theo danh mục - 1: Có - 0: Không
- `diachi_diachichitiet`: Địa chỉ chi tiết
- `email_thongtinlienhe`: Email
- `fax_thongtinlienhe`: Fax
- `hinhthucthanhlap`: Hình thức thành lập theo danh mục của bộ ngành 1. Thành lập mới 2. Nâng cấp 3. Liên kết

## Organization Unit
- Domain: Institution & Organization
- Source tables: `thongtincocautochuc`

- `loaiphongban`: Loại phòng ban, đơn vị theo danh mục của bộ ngành
- `maddtc`: Mã định danh điện tử tổ chức
- `maphongban`: Mã phòng ban, đơn vị
- `maphongbancha`: Mã phòng ban đơn vị cha Tham chiếu đến dữ liệu cơ cấu tổ chức
- `quyetdinhthanhlap_ngayqd`: Ngày ký quyết định thành lập. Định dạng YYYY-MM-DD
- `quyetdinhthanhlap_soqd`: Số quyết định thành lập
- `tenphongban`: Tên phòng ban, đơn vị
- `trangthaihdtc`: Trạng thái hoạt động tổ chức theo danh mục của bộ ngành
- `macosodaotao` [FK]: Mã cơ sở đào tạo quản lý Tham chiếu đến dữ liệu Cơ sở giáo dục đại học
- `keythongtincocautochuc` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ  hệ thống

## Building
- Domain: Institution & Organization
- Source tables: `thongtintoanha`

- `diachichitiet`: Địa chỉ chi tiết
- `dientichxaydung`: Diện tích xây dựng (m2)
- `hinhthucsohuu`: Hình thức sở hữu theo danh mục của bộ ngành
- `matoanha`: Mã tòa nhà
- `nambdsudung`: Năm bắt đầu sử dụng. Định dạng YYYY
- `ngaychuyentrangthai`: Ngày chuyển trạng thái. Định dạng YYYY-MM-DD
- `phuongxa`: Xã, phường, thị trấn
- `sotang`: Số tầng
- `tentoanha`: Tên tòa nhà
- `tinhtp`: Tỉnh, thành phố trực thuộc trung ương
- `tinhtrangsudung`: Tình trạng sử dụng tòa nhà theo danh mục của bộ ngành
- `tongdientichsan`: Tổng diện tích sàn xây dựng (m2)

## Land / Facility Asset
- Domain: Institution & Organization
- Source tables: `csvcvatrangthietbidatdai`, `csvcvatrangthietbidatdai_doituongsohuu_nguoivn`, `csvcvatrangthietbidatdai_doituongsohuu_dinhdanhtochuc`

- `diachichitiet`: Địa chỉ chi tiết
- `dientichdasudung`: Diện tích đất đã sử dụng (m2)
- `dientichdat`: Diện tích đất (m2)
- `hinhthucsohuu`: Hình thức sở hữu theo danh mục của bộ ngành
- `magcn`: Mã giấy chứng nhận quyền sở hữu
- `minhchungquyensohuu`: Minh chứng quyền sở hữu đất đai
- `mucdichsudung`: Mục đích sử dụng đất theo danh mục của bộ ngành
- `nambdsudung`: Năm bắt đầu sử dụng của khu đất. Định dạng YYYY
- `ngaychuyentrangthai`: Ngày chuyển trạng thái. Định dạng YYYY-MM-DD
- `phuongxa`: Xã, phường, thị trấn
- `thoigiansudung`: Thời gian sử dụng của khu đất theo số năm
- `tinhtp`: Tỉnh, thành phố trực thuộc trung ương

## Teaching Room / Hall
- Domain: Institution & Organization
- Source tables: `phonghocgiangduongvahoitruong`

- `chongoi`: Quy mô chỗ ngồi
- `diachichitiet`: Địa chỉ chi tiết
- `dientich`: Diện tích
- `hinhthucsohuu`: Hình thức sở hữu quy định theo danh mục
- `loaidean`: Loại đề án/dự án
- `loaiphonghoc`: Loại phòng học
- `maphonghocgdht`: Mã phòng học, giảng đường, hội trường
- `namsudung`: Năm đưa vào sử dụng. Định dạng YYYY
- `ngaychuyentrangthai`: Ngày chuyển trạng thái. Định dạng YYYY-MM-DD
- `phanloai`: Phân loại
- `phuongxa`: Xã, phường, thị trấn
- `tenphonghocgdht`: Tên phòng, giảng đường, hội trường

## Learner
- Domain: Learner Profile
- Source tables: `ttchunghocvien`, `ttchunghocvien_nguoivn`, `ttchunghocvien_nguoivn_giaytodinhdanhcn`, `ttchunghocvien_congdannuocngoai`, `ttchunghocvien_congdannuocngoai_giaytodinhdanhnn`

- `email`: Email
- `hotencha`: Họ tên cha
- `hotenme`: Họ tên mẹ
- `hotennguoigiamho`: Họ tên người giám hộ
- `loaikhuyettat`: Loại khuyết tật
- `macosodaotao`: Mã cơ sở đào tạo quản lý Tham chiếu đến dữ liệu Cơ sở giáo dục đại học
- `mahocvien`: Mã sinh viên tại trường
- `masobhxh`: Mã sổ bảo hiểm xã hội
- `ngayvaodang`: Ngày vào đảng. Định dạng YYYY-MM-DD
- `ngayvaodangchinhthuc`: Ngày vào đảng chính thức. Định dạng YYYY-MM-DD
- `ngayvaodoan`: Ngày vào đoàn. Định dạng YYYY-MM-DD
- `nghenghiepcha`: Nghề nghiệp của cha

## Postgraduate Study Record
- Domain: Learning & Study
- Source tables: `thongtinhoctapsvdh`, `thongtinhoctapsvdh_nguoivn`, `thongtinhoctapsvdh_congdannuocngoai`, `ThongTinHocTapSVDH_QuyetDinhThoiHocBaoLuu`

- `bangtotnghieplienthong`: Bằng tốt nghiệp liên thông  - 1: Có - 0: Không
- `chuongtrinhdaotao`: Chương trình đào tạo
- `coquanqd`: Cơ quan quyết định. Bắt buộc khi QuyetDinhNhapHoc có dữ liệu
- `coquanqd_2`: Cơ quan quyết định. Bắt buộc khi QuyetDinhThoiHocBaoLuu có dữ liệu
- `coquanqd_3`: Cơ quan quyết định. Bắt buộc có dữ liệu khi QuyetDinhTotNghiep có dữ liệu
- `coquanqd_4`: Cơ quan quyết định. Bắt buộc có dữ liệu khi QuyetDinhHocVi có dữ liệu
- `dangonoitru`: Đang ở nội trú  - 1: Có - 0: Không
- `daotaoden`: Đào tạo đến năm. Định dạng YYYY
- `daotaotu`: Đào tạo từ năm. Định dạng YYYY
- `doituongdauvao`: Đối tượng đầu vào:  - Đối với đại học: Cử tuyển, Tốt nghiệp THPT, Tốt nghiệp trung cấp, Tốt nghiệp cao đẳng, Tốt nghiệp đại học; - Đối với thạc sĩ: Tốt nghiệp THPT, đại học;  - Đối với nghiên cứu sinh: Cử nhân, Specilist, thạc sĩ
- `dsquyetdinhthoihocbaoluu`: Danh sách quyết định thôi học/buộc thôi học/bảo lưu.  Thông tin không bắt buộc có dữ liệu
- `idthongtinhoctap`: Id thông tin học tập

## Credential / Certificate
- Domain: Credential & Certificate
- Source tables: `VanBangChungChi`, `VanBangChungChi_ThongTinHieuChinh`

- `chucvu`: Chức vụ người ký
- `donvicap`: Đơn vị cấp bằng
- `hinhthucdaotao`: Hình thức đào tạo
- `hoidongthi`: Hội đồng thi
- `hovaten`: Họ và tên công dân
- `khoathi`: Khóa thi
- `madinhdanhvbcc`: Mã định danh văn bằng chứng chỉ
- `mahocvien`: Mã học viên
- `matruong`: Mã trường. Tham chiếu đến datatye: data_green_g03_gddt010 trong bảng mã dịch vụ
- `namsinh`: Năm sinh. Định dạng YYYY
- `namtotnghiep`: Năm tốt nghiệp. Định dạng YYYY
- `ngaycap_nam`: Năm cấp văn bằng. Định dạng YYYY

## Reward
- Domain: Reward & Discipline
- Source tables: `KhenThuong`, `KhenThuong_NguoiVN`, `KhenThuong_CongDanNuocNgoai`

- `doituong`: Đối tượng khen thưởng theo danh mục - 1: Giáo viên/giảng viên - 2: Thông tin học tập học viên/sinh viên
- `namkhenthuong`: Năm khen thưởng. Định dạng YYYY
- `noidungkhenthuong`: Nội dung khen thưởng
- `quyetdinhkhenthuong_ngayqd`: Ngày quyết định. Định dạng YYYY-MM-DD
- `quyetdinhkhenthuong_soqd`: Số quyết định khen thưởng
- `thanhtichkhenthuong`: Thành tích thi đua, khen thưởng
- `capkhenthuong` [FK]: Cấp khen thưởng theo danh mục của bộ ngành
- `hinhthuckhenthuong` [FK]: Hình thức khen thưởng theo danh mục (Căn cứ: Điều 9, Luật thi đua, khen thưởng năm 2022) - 00: Huân chương - 01: Huy chương - 02: Danh hiệu vinh dự nhà nước - 03: Giải thưởng Hồ Chí Minh", "Giải thưởng nhà nước" - 04: Kỷ niệm chương - 05: Bằng khen - 06: Giấy khen - 07: Chưa xác định
- `idthongtinhoctap` [FK]: ID thông tin học tập của học viên/sinh viên Tham chiếu đến dữ liệu Thông tin học tập
- `loaikhenthuong` [FK]: Mã loại khen thưởng theo danh mục (Căn cứ: Điều 8, Luật thi đua, khen thưởng năm 2022)
- `macosodaotao` [FK]: Mã cơ sở đào tạo quản lý Tham chiếu đến dữ liệu Cơ sở giáo dục đại học
- `phuongthuckhenthuong` [FK]: Phương thức khen thưởng theo danh mục của bộ ngành

## Discipline
- Domain: Reward & Discipline
- Source tables: `KyLuat`, `KyLuat_NguoiVN`, `KyLuat_CongDanNuocNgoai`

- `capkyluat`: Cấp kỷ luật
- `denngay`: Ngày kết thúc kỷ luật. Định dạng YYYY-MM-DD
- `doituong`: Đối tượng kỷ luật theo danh mục - 1: Giáo viên/giảng viên - 2: Thông tin học tập học viên/sinh viên
- `hanhvikyluat`: Hành vi kỷ luật
- `lydokyluat`: Lý do
- `macosodaotao`: Mã cơ sở đào tạo quản lý Tham chiếu đến dữ liệu Cơ sở giáo dục đại học
- `maloaikyluat`: Loại kỷ luật theo danh mục căn cứ Nghị định số 112/2020/NĐ-CP ngày 18 tháng 9 năm 2020 của Chính phủ; được sửa đổi, bổ sung bởi Nghị định số 71/2023/NĐ-CP ngày 20 tháng 9 năm 2023 của Chính phủ - 01: Khiển trách - 02: Cảnh cáo - 03: Cách chức - 04: Bãi nhiệm - 05: Hạ bậc lương - 06: Giáng chức - 07: Buộc thôi việc - 99: Khác
- `namkyluat`: Năm kỷ luật. Định dạng YYYY
- `quyetdinhkyluat_capquyetdinh`: Cấp quyết định
- `quyetdinhkyluat_ngayqd`: Ngày quyết định. Định dạng YYYY-MM-DD
- `quyetdinhkyluat_soqd`: Số quyết định
- `tungay`: Ngày bắt đầu bị kỷ luật. Định dạng YYYY-MM-DD

## Staff / Lecturer
- Domain: Staff & Lecturer
- Source tables: `ThongTinCanBoGiangVien`, `ThongTinCanBoGiangVien_NguoiVN`, `ThongTinCanBoGiangVien_NguoiVN_GiayToDinhDanhCN`, `ThongTinCanBoGiangVien_CongDanNuocNgoai`, `ThongTinCanBoGiangVien_CongDanNuocNgoai_GiayToDinhDanhNN`

- `bacsiduocsicki`: Bác sĩ/Dược sĩ chuyên khoa I: - 1: Có - 0: Không
- `bacsiduocsickii`: Bác sĩ/Dược sĩ chuyên khoa II: - 1: Có - 0: Không
- `ccsuphamgiangvien`: Chứng chỉ sư phạm giảng viên: - 1: Có - 0: Không
- `cholamviecrieng`: Có chỗ làm việc riêng (Tối thiểu 6m2): - 1: Có - 0: Không
- `chuyenmondaotao`: Chuyên môn được đào tạo quy định theo danh mục của bộ ngành
- `cqcongtac`: Cơ quan công tác (Giáo viên thỉnh giảng)
- `email`: Email
- `lacongchuc`: Là công chức (giảng viên thỉnh giảng k nhập cột này): - 1: Có - 0: Không
- `lavienchuc`: Là viên chức (giảng viên thỉnh giảng k nhập cột này):  - 1: Có - 0: Không
- `macanbo`: Mã cán bộ
- `makhungnlngoaingu`: Mã khung năng lực ngoại ngữ theo danh mục của bộ ngành
- `masobhxh`: Số sổ bảo hiểm xã hội

## Work Unit Assignment
- Domain: Staff & Lecturer
- Source tables: `PhongBanDonViCongTac`, `PhongBanDonViCongTac_NguoiVN`, `PhongBanDonViCongTac_CongDanNuocNgoai`

- `denngay`: Thời gian kết thúc công tác. Định dạng YYYY-MM-DD
- `donvichinh`: Là đơn vị chính: - 1: Có - 0: Không
- `donvigiangday`: Là đơn vị giảng dạy: - 1: Có - 0: Không
- `ngayqd`: Ngày quyết định. Định dạng YYYY-MM-DD
- `soqd`: Số quyết định
- `tungay`: Thời gian bắt đầu công tác. Định dạng YYYY-MM-DD
- `chucvucongtac` [FK]: Chức vụ công tác quy định theo danh mục của bộ ngành
- `hinhthucbonhiem` [FK]: Hình thức bổ nhiệm quy định theo danh mục của bộ ngành
- `macosodaotao` [FK]: Mã cơ sở đào tạo quản lý Tham chiếu đến thông tin Cơ sở giáo dục đại học
- `maphongban` [FK]: Mã phòng ban, đơn vị Tham chiếu thông tin cơ cấu tổ chức
- `keyphongbandonvicongtac` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ  hệ thống
- `hovaten`: Họ, chữ đệm và tên khai sinh

## Teaching / Work History
- Domain: Staff & Lecturer
- Source tables: `QuaTrinhCongTacCuaCanBoGiangVien`, `QuaTrinhCongTacCuaCanBoGiangVien_NguoiVN`, `QuaTrinhCongTacCuaCanBoGiangVien_CongDanNuocNgoai`

- `donvithinhgiang`: Đơn vị thỉnh giảng Tham chiếu thông tin Cơ sở giáo dục đào tạo
- `nganhchinh`: Là ngành chính: - 1: Có - 0: Không
- `macosodaotao` [FK]: Mã cơ sở đào tạo quản lý Tham chiếu đến dữ liệu Cơ sở giáo dục đại học
- `manganhgiangday` [FK]: Mã ngành giảng dạy theo danh mục của bộ ngành
- `trinhdogiangday` [FK]: Trình độ giảng dạy (Trình độ tương ứng với Mã ngành giảng dạy) theo danh mục của bộ ngành
- `keyquatrinhcongtaccuacanbogiangvien` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ  hệ thống
- `hovaten`: Họ, chữ đệm và tên khai sinh
- `namsinh`: Năm sinh. Định dạng YYYY
- `ngaythangnamsinh`: Ngày tháng năm sinh. Định dạng YYYY-MM-DD
- `sodinhdanh`: Số định danh cá nhân
- `thangnamsinh`: Tháng năm sinh. Định dạng YYYY-MM
- `keyquatrinhcongtaccuacanbogiangviennguoivn` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ  hệ thống

## Staff Education / Training History
- Domain: Staff & Lecturer
- Source tables: `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien`, `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_NguoiVN`, `QuaTrinhDaoTaoBoiDuongCuaCanBoGiangVien_CongDanNuocNgoai`

- `cosodaotao`: Cơ sở đào tạo
- `namtn`: Năm tốt nghiệp. Định dạng YYYY
- `quocgiadaotao`: Quốc gia đào tạo theo danh mục quy định tại phụ lục của tài liệu
- `thoigianbddaotao`: Thời gian bắt đầu đào tạo. Định dạng YYYY-MM-DD
- `thoigianktdaotao`: Thời gian kết thúc đào tạo. Định dạng YYYY-MM-DD
- `loaihinhdaotao` [FK]: Loại hình đào tạo quy định theo danh mục của bộ ngành
- `macosodaotao` [FK]: Mã cơ sở đào tạo quản lý Tham chiếu đến dữ liệu Cơ sở giáo dục đại học
- `nganhdaotao` [FK]: Ngành đào tạo theo danh mục được quy định tại Thông tư số 26/2020/TT-BLĐTBXH ngày 30 tháng 12 năm 2020 của Bộ trưởng Bộ Lao động – Thương binh và Xã hội và Thông tư số 09/2022/TT-BGDĐT ngày 06 tháng 6 năm 2022 của Bộ trưởng Bộ Giáo dục và Đào tạo
- `trinhdodaotao` [FK]: Trình độ được đào tạo theo danh mục Căn cứ: Quyết định số 06/2007/QĐ-BNV ngày 18 tháng 6 năm 2007 của Bộ trưởng Bộ Nội vụ
- `keyquatrinhdaotaoboiduongcuacanbogiangvien` [PK]: Key kỹ thuật, sử dụng để mapping nghiệp vụ  hệ thống
- `hovaten`: Họ, chữ đệm và tên khai sinh
- `namsinh`: Năm sinh. Định dạng YYYY

## Training Major
- Domain: Learning & Study
- Source tables: `DanhSachNganhDaoTao`

- `coquanbanhanh`: Cơ quan ban hành
- `hinhthucdaotaocn`: Hình thức đào tạo theo chuyên ngữ: - 1: Có - 0: Không
- `nambddaotao`: Năm bắt đầu đào tạo. Định dạng YYYY
- `namdtgannhat`: Năm tuyển sinh và đào tạo gần nhất. c. Định dạng YYYY
- `nguoiky`: Người ký
- `qddoitennganh_ngayqd`: Ngày quyết định. Định dạng YYYY-MM-DD
- `qddoitennganh_spqd`: Số quyết định
- `qdmonganh_ngayqd`: Ngày quyết định. Định dạng YYYY-MM-DD
- `qdmonganh_soqd`: Số quyết định
- `quyetdinhtuchu`: Quyết định tự chủ
- `sonamdaotaotsts`: Số năm đào tạo thạc sĩ, tiến sĩ
- `tennganhmolandau`: Tên ngành mở lần đầu

## Training Program
- Domain: Learning & Study
- Source tables: `ChuongTrinhDaoTao`

- `chuandaura`: Chuẩn đầu ra
- `chuandaurangoaingu`: Chuẩn đầu ra về ngoại ngữ
- `chuandauratinhoc`: Chuẩn đầu ra tin học
- `diachichitiet`: Địa chỉ chi tiết
- `donvithuchien`: Đơn vị thực hiện chương trình
- `dsloaiccchapthuan_loaiccchapthuan`: Loại chứng chỉ được chấp thuận cho chương trình
- `hocphinn`: Học phí tại nước ngoài
- `hocphivn`: Học phí tại Việt Nam
- `namtuyensinh`: Năm bắt đầu tuyển sinh. Định dạng YYYY
- `ngaybanhanhdaura`: Ngày tháng năm ban hành Chuẩn đầu ra. Định dạng YYYY-MM-DD
- `phuongxa`: Xã, phường, thị trấn
- `quyetdinhbanhanh_ngayqd`: Ngày quyết định. Định dạng YYYY-MM-DD
