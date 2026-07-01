CREATE DATABASE IF NOT EXISTS `book1` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `book1`;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `thongtindiemtruongchinhcapmnththcsthpt`;
CREATE TABLE `thongtindiemtruongchinhcapmnththcsthpt` (
  `keythongtindiemtruongchinhcapmnththcsthpt` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `maddtc` VARCHAR(35) NOT NULL COMMENT 'Mã định danh cho cơ sở giáo dục',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường được sinh theo quy tắc: Mã sở + Mã Phường/Xã + STT tự tăng',
  `tentruong` VARCHAR(200) NOT NULL COMMENT 'Tên trường',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `maloaihinhtruong` VARCHAR(1) NOT NULL COMMENT 'Mã loại hình trường theo danh mục quy định tại khoản 1 Điều 47 Luật Giáo dục năm 2019
1 - Trường công lập
2 - Trường dân lập
3 - Trường tư thục',
  `maloaitruong` VARCHAR(20) COMMENT 'Mã loại trường theo danh mục của bộ ngành
Nhóm cấp học là mầm non không có thông tin này',
  `makhuvuc` VARCHAR(1) NOT NULL COMMENT 'Mã khu vực theo danh mục quy định tại thông tư 08/2025/TT-BCA
0 - Chưa xác định
1 - Khu vực 1 (KV1)
2 - Khu vực 2 (KV2)
3 - Khu vực 2 nông thôn (KV2-NT)
4 - Khu vực 3',
  `machatluonggiaoduc` VARCHAR(5) COMMENT 'Mã đạt chuẩn đánh giá chất lượng giáo dục theo danh mục của bộ ngành',
  `maduan` VARCHAR(10) COMMENT 'Mã dự án theo danh mục của bộ ngành
Nhóm cấp học là mầm non không có thông tin này',
  `vitribando` DOUBLE COMMENT 'Vị trí bản đồ',
  `diachi_diachichitiet` VARCHAR(255) NOT NULL COMMENT 'Địa chỉ chi tiết',
  `diachi_maxa` VARCHAR(5) NOT NULL COMMENT 'Mã xã, phường, thị trấn theo quy định tại phụ lục của tài liệu',
  `diachi_mahuyen` VARCHAR(3) COMMENT 'Mã quận, huyện, thị xã, thành phố theo quy định tại phụ lục của tài liệu',
  `diachi_matinh` VARCHAR(2) NOT NULL COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo quy định tại phụ lục của tài liệu',
  `sodienthoai` VARCHAR(20) NOT NULL COMMENT 'Số điện thoại',
  `email` VARCHAR(50) NOT NULL COMMENT 'Email',
  `fax` VARCHAR(20) NOT NULL COMMENT 'Fax',
  `website` VARCHAR(50) NOT NULL COMMENT 'Website',
  `sodiemtruong` VARCHAR(20) COMMENT 'Số điểm trường
Nhóm cấp học mầm non không có thông tin này',
  `hieutruong_hovaten` VARCHAR(150) NOT NULL COMMENT 'Tên hiệu trưởng',
  `hieutruong_sodienthoai` VARCHAR(20) NOT NULL COMMENT 'Điện thoại hiệu trưởng',
  `hieutruong_email` VARCHAR(50) COMMENT 'Email hiệu trưởng',
  `cochibodang` BOOLEAN NOT NULL COMMENT 'Có chi bộ đảng theo danh mục
1 - Có
0 - Không',
  `LaTruongDatChuanQuocGia` BOOLEAN NOT NULL COMMENT 'Có phải là trường đạt chuẩn quốc gia 
0 - Không
1 - Có',
  `LaTruongQuocTe` BOOLEAN NOT NULL COMMENT 'Có phải là trường quốc tế 
0 - Không
1 - Có',
  `CoHocSinhKhuyetTat` BOOLEAN NOT NULL COMMENT 'Có học sinh khuyết tật 
1 - Có
0 - Không',
  `CoHocSinhBanTru` BOOLEAN NOT NULL COMMENT 'Có học sinh bán trú 
1 - Có
0 - Không',
  `CoThuocVungDacBietKhoKhan` BOOLEAN NOT NULL COMMENT 'Có thuộc vùng đặc biệt khó khăn 
1 - Có
0 - Không',
  `CoDay2BuoiNgay` BOOLEAN NOT NULL COMMENT 'Có dạy 2 buổi/ngày 
1 - Có
0 - Không',
  `CoSuDungMayViTinh` BOOLEAN NOT NULL COMMENT 'Có sử dụng máy vi tính phục vụ quản lý và giáo dục trẻ 
1 - Có
0 - Không',
  `DuocKetNoiInternet` BOOLEAN NOT NULL COMMENT 'Được kết nối Internet
1 - Có
0 - Không',
  `CoDienLuoi` BOOLEAN NOT NULL COMMENT 'Có điện lưới
1 - Có
0 - Không',
  `CoNguonNuocSach` BOOLEAN NOT NULL COMMENT 'Có nguồn nước sạch
1 - Có
0 - Không',
  `CoCongTrinhVeSinhTheoGioiTinh` BOOLEAN NOT NULL COMMENT 'Có công trình vệ sinh
1 - Có
0 - Không',
  `CoChuongTrinhGiaoDucVeSinhDoiTay` BOOLEAN NOT NULL COMMENT 'Có chương trình giáo dục vệ sinh đôi tay 
1 - Có
0 - Không',
  `CoChuongTrinhGiaoDucGioiTinh` BOOLEAN NOT NULL COMMENT 'Có chương trình giáo dục cơ bản
1 - Có
0 - Không',
  `CoKyNangSong` BOOLEAN COMMENT 'Có học kỹ năng sống
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `CoHocSinhNoiTru` BOOLEAN COMMENT 'Có học sinh nội trú
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `CoChatLuongToiThieu` BOOLEAN COMMENT 'Có đạt chất lượng tối thiểu
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `DuThietBiDayHocToiThieu` VARCHAR(20) COMMENT 'Đủ thiết bị dạy học tối thiểu
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `CoDayNghePhoThong` BOOLEAN COMMENT 'Có dạy nghề phổ thông
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `CoLopKhongChuyen` BOOLEAN COMMENT 'Có lớp không chuyên
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `CoHaTangTiepCanHocSinhKhuyetTat` BOOLEAN COMMENT 'Có hạ tầng tiếp cận học sinh khuyết tật
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `bptuvanhocduong` BOOLEAN COMMENT 'Có bộ phận công tác tư vấn học đường
1 - Có
0 - Không
Nhóm cấp học mầm non không có thông tin này',
  `DatKiemDinhCapDo` VARCHAR(1) NOT NULL COMMENT 'Đạt kiểm định cấp độ theo danh mục quy định tại khoản 2 Điều 34 Thông tư số 19/2018/TT-BGDĐT
1 - Cấp độ 1
2 - Cấp độ 2
3 - Cấp độ 3
4 - Cấp độ 4',
  `HangTruong` VARCHAR(10) COMMENT 'Hạng trường',
  `DienTich` DOUBLE COMMENT 'Diện tích',
  `ngaythangnam_thanhlap` DATE COMMENT 'Ngày tháng năm thành lập. Định dạng YYYY-MM-DD',
  `thangnam_thanhlap` VARCHAR(7) COMMENT 'Tháng năm thành lập. Định dạng YYYY-MM',
  `nam_thanhlap` VARCHAR(4) COMMENT 'Năm thành lập. Định dạng YYYY',
  `mavung` VARCHAR(35) COMMENT 'Mã vùng theo danh mục của bộ ngành',
  `tenvung` VARCHAR(150) NOT NULL COMMENT 'Tên vùng',
  `cohoctructuyen` BOOLEAN COMMENT 'Có học trực truyến
1 - Có
0 - Không',
  `mavungkhokhan` VARCHAR(5) COMMENT 'Mã vùng khó khăn theo quy định tại Quyết định số 4998/QĐBGDĐT',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindiemtruongchinhcapmnththcsthpt`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`),
  KEY `idx_maloaihinhtruong` (`maloaihinhtruong`),
  KEY `idx_maloaitruong` (`maloaitruong`),
  KEY `idx_makhuvuc` (`makhuvuc`),
  KEY `idx_machatluonggiaoduc` (`machatluonggiaoduc`),
  KEY `idx_diachi_maxa` (`diachi_maxa`),
  KEY `idx_diachi_mahuyen` (`diachi_mahuyen`),
  KEY `idx_diachi_matinh` (`diachi_matinh`),
  KEY `idx_DatKiemDinhCapDo` (`DatKiemDinhCapDo`),
  KEY `idx_mavung` (`mavung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtindiemtruongcapmnththcsthpttx`;
CREATE TABLE `thongtindiemtruongcapmnththcsthpttx` (
  `keythongtindiemtruongcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã điểm trường chính/mã trung tâm thường xuyên
Tham chiếu thông tin điểm trưởng chính cấp mầm non',
  `madiemtruong` VARCHAR(20) NOT NULL COMMENT 'Mã điểm trường',
  `tendiemtruong` VARCHAR(200) NOT NULL COMMENT 'Tên điểm trường',
  `sodienthoai` VARCHAR(12) NOT NULL COMMENT 'Số điện thoại',
  `kcdentruongchinh` DOUBLE COMMENT 'Khoảng cách đến trường chính (km)',
  `phuongtiendilai` VARCHAR(150) COMMENT 'Phương tiện có thể đi lại',
  `dientich` DOUBLE COMMENT 'Diện tích (m2)',
  `diachi_diachichitiet` VARCHAR(255) NOT NULL COMMENT 'Địa chỉ chi tiết',
  `diachi_maxa` VARCHAR(5) NOT NULL COMMENT 'Mã xã, phường, thị trấn theo quy định tại phụ lục của tài liệu',
  `diachi_mahuyen` VARCHAR(3) COMMENT 'Mã quận, huyện, thị xã, thành phố theo quy định tại phụ lục của tài liệu',
  `diachi_matinh` VARCHAR(2) NOT NULL COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo quy định tại phụ lục của tài liệu',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindiemtruongcapmnththcsthpttx`),
  KEY `idx_diachi_maxa` (`diachi_maxa`),
  KEY `idx_diachi_mahuyen` (`diachi_mahuyen`),
  KEY `idx_diachi_matinh` (`diachi_matinh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `lopmamnon`;
CREATE TABLE `lopmamnon` (
  `keylopmamnon` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường',
  `madiemtruong` VARCHAR(20) NOT NULL COMMENT 'Mã điểm trường',
  `makhoi` VARCHAR(20) NOT NULL COMMENT 'Mã khối theo danh mục quy định tại Quyết định số 4998/QĐ-BGDĐT ngày 31 tháng 12 năm 2021 của Bộ trưởng Bộ Giáo dục và Đào tạo và các văn bản sửa đổi, bổ sung, điều chỉnh (nếu có)
0 - Chưa xác định',
  `malop` VARCHAR(20) NOT NULL COMMENT 'Mã lớp',
  `tenlop` VARCHAR(150) NOT NULL COMMENT 'Tên lớp',
  `manhomtuoimamnon` VARCHAR(20) NOT NULL COMMENT 'Mã nhóm tuổi mầm non theo danh mục',
  `magiaoviencn` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên chủ nhiệm
Tham chiếu thông tin Giáo viên chủ nhiệm',
  `coday2buoingay` BOOLEAN NOT NULL COMMENT 'Có dạy 2 buổi/ngày
0 - Không
1 - Có',
  `ghep2tuoi` BOOLEAN NOT NULL COMMENT 'Là lớp ghép 2 tuổi
0 - Không
1 - Có',
  `ghep3tuoi` BOOLEAN NOT NULL COMMENT 'Là lớp ghép 3 tuổi
0 - Không
1 - Có',
  `ghep4tuoi` BOOLEAN NOT NULL COMMENT 'Là lớp ghép 4 tuổi
0 - Không
1 - Có',
  `lopghep` BOOLEAN NOT NULL COMMENT 'Là lớp ghép
0 - Không
1 - Có',
  `capnhatlopghep` BOOLEAN NOT NULL COMMENT 'Có cập nhật lớp ghép
0 - Không
1 - Có',
  `lopbantru` BOOLEAN NOT NULL COMMENT 'Là lớp bán trú
0 - Không
1 - Có',
  `cotrekhuyettat` BOOLEAN NOT NULL COMMENT 'Là lớp có trẻ khuyết tật
0 - Không
1 - Có',
  `coctgdmnmoi` BOOLEAN NOT NULL COMMENT 'Là lớp có chương trình mầm non mới
0 - Không
1 - Có',
  `coctcsgd` BOOLEAN NOT NULL COMMENT 'Là lớp có chương trình chăm sóc giáo dục
0 - Không
1 - Có',
  `malopghep` VARCHAR(15) COMMENT 'Mã lớp ghép
Tham chiếu thông tin lớp ghép',
  `mahocbantru` VARCHAR(20) COMMENT 'Mã học bán trú theo danh mục',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keylopmamnon`),
  KEY `idx_makhoi` (`makhoi`),
  KEY `idx_manhomtuoimamnon` (`manhomtuoimamnon`),
  KEY `idx_mahocbantru` (`mahocbantru`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx` (
  `keythongtinhocsinhcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường',
  `makhoi` VARCHAR(20) NOT NULL COMMENT 'Mã khối theo danh mục quy định tại Quyết định số 4998/QĐ-BGDĐT',
  `malop` VARCHAR(20) NOT NULL COMMENT 'Mã lớp',
  `mahocsinh` VARCHAR(20) NOT NULL COMMENT 'Mã học sinh',
  `chieucao` DOUBLE NOT NULL COMMENT 'Chiều cao',
  `cannang` DOUBLE NOT NULL COMMENT 'Cân nặng',
  `nhommau` VARCHAR(2) NOT NULL COMMENT 'Nhóm máu theo danh mục quy định tại phụ lục tài liệu',
  `chisobmi` VARCHAR(150) COMMENT 'Chỉ số (BMI)',
  `benhvemat` VARCHAR(150) COMMENT 'Các bệnh về mắt',
  `benhbamsinh` VARCHAR(150) COMMENT 'Các bệnh bẩm sinh',
  `benhcotsong` VARCHAR(150) COMMENT 'Các bệnh về cột sống',
  `benhcoixuong` VARCHAR(150) COMMENT 'Bệnh còi xương',
  `matrangthaihientai` VARCHAR(20) NOT NULL COMMENT 'Mã trạng thái hiện tại của học sinh theo danh mục của bộ ngành',
  `malydothoihoc` VARCHAR(20) COMMENT 'Mã lý do thôi học theo danh mục của bộ ngành',
  `makhuvuc` VARCHAR(20) NOT NULL COMMENT 'Mã khu vực theo danh mục của bộ ngành',
  `maloaikhuyettat` VARCHAR(20) COMMENT 'Mã loại khuyết tật theo danh mục của bộ ngành',
  `malophuongnghiep` VARCHAR(20) COMMENT 'Mã lớp hướng nghiệp dạy nghề theo danh mục. 
Tham chiếu đến dữ liệu Lớp học giáo dục thường xuyên
Nhóm cấp học mầm non không có thông tin này',
  `cokhuyettatkhongdanhgia` BOOLEAN NOT NULL COMMENT 'Có phải khuyết tật không đánh giá
0 - Không
1 - Có',
  `cohoc2buoi` BOOLEAN NOT NULL COMMENT 'Học 2 buổi
0 - Không
1 - Có',
  `cohocsinhbantru` BOOLEAN COMMENT 'Là học sinh lớp bán trú
0 - Không
1 - Có',
  `bietboi` BOOLEAN COMMENT 'Có biết bơi không
0 - Không
1 - Có',
  `codoivien` BOOLEAN COMMENT 'Là đội viên
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `codoanvien` BOOLEAN COMMENT 'Là đoàn viên
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cohocsinhtiengdantoc` BOOLEAN COMMENT 'Học sinh học tiếng dân tộc
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cohocsinhptdantocbantru` BOOLEAN COMMENT 'Học sinh phổ thông dân tộc bán trú
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `conhucauhotrongoaingu` BOOLEAN COMMENT 'Nhu cầu hỗ trợ ngoại ngữ
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cotangcuongtiengviet` BOOLEAN COMMENT 'Tăng cường tiếng việt
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cohocsinhdantoctrogiang` BOOLEAN COMMENT 'Học sinh dân tộc trợ giảng
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `coluubannamtruoc` BOOLEAN COMMENT 'Lưu ban năm trước
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cohotronhao` BOOLEAN COMMENT 'Hỗ trợ nhà ở
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cocaptienhangthang` BOOLEAN COMMENT 'Cấp tiền hàng tháng
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cocapgao` BOOLEAN COMMENT 'Cấp gạo
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `cohocctgdcuabo` BOOLEAN COMMENT 'Học chương trình GD của bộ
0 - Không
1 - Có
Nhóm cấp học mầm non không có thông tin này',
  `sodienthoai` VARCHAR(12) COMMENT 'Số điện thoại liên hệ',
  `madienchinhsach` VARCHAR(20) COMMENT 'Mã diện chính sách theo danh mục của bộ ngành',
  `hongheo` BOOLEAN NOT NULL COMMENT 'Có phải hộ nghèo không
0 - Không
1 - Có',
  `chadantoc` BOOLEAN NOT NULL COMMENT 'Có cha dân tộc không
0 - Không
1 - Có',
  `medantoc` BOOLEAN NOT NULL COMMENT 'Có mẹ dân tộc khong
0 - Không
1 - Có',
  `vungkhokhan` BOOLEAN NOT NULL COMMENT 'Có thuộc vùng khó khăn không
0 - Không
1 - Có',
  `comienhocphi` BOOLEAN COMMENT 'Có Miễn học phí không
0 - Không
1 - Có',
  `cogiamhocphi` BOOLEAN NOT NULL COMMENT 'Có Giảm học phí không
0 - Không
1 - Có',
  `cohotrochiphihoctap` BOOLEAN NOT NULL COMMENT 'Có Hỗ trợ chi phí học tập không
0 - Không
1 - Có',
  `cohotroantrua` BOOLEAN NOT NULL COMMENT 'Có Hỗ trợ ăn trưa không
0 - Không
1 - Có',
  `tuyenmoimamnon` BOOLEAN NOT NULL COMMENT 'Có phải tuyển mới mầm non không
0 - Không
1 - Có',
  `mahocbantru` VARCHAR(20) NOT NULL COMMENT 'Mã học bán trú theo danh mục của bộ ngành',
  `noidungbaoluchd` VARCHAR(255) COMMENT 'Nội dung bạo lực học đường',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`),
  KEY `idx_makhoi` (`makhoi`),
  KEY `idx_nhommau` (`nhommau`),
  KEY `idx_matrangthaihientai` (`matrangthaihientai`),
  KEY `idx_malydothoihoc` (`malydothoihoc`),
  KEY `idx_makhuvuc` (`makhuvuc`),
  KEY `idx_maloaikhuyettat` (`maloaikhuyettat`),
  KEY `idx_malophuongnghiep` (`malophuongnghiep`),
  KEY `idx_madienchinhsach` (`madienchinhsach`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_nguoivn`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_nguoivn` (
  `keythongtinhocsinhcapmnththcsthpttx_nguoivn` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `sodinhdanh` VARCHAR(12) NOT NULL COMMENT 'Số định danh cá nhân',
  `hovaten` VARCHAR(150) NOT NULL COMMENT 'Họ, chữ đệm và tên khai sinh',
  `tenkhac` VARCHAR(150) COMMENT 'Tên viết tắt/Tên khác',
  `gioitinh` VARCHAR(1) NOT NULL COMMENT 'Giới tính theo danh mục:
0 - Chưa có thông tin
1 - Giới tính nam
2 - Giới tính nữ',
  `ngaythangnamsinh` DATE COMMENT 'Ngày tháng năm sinh. Định dạng YYYY-MM-DD',
  `thangnamsinh` VARCHAR(7) COMMENT 'Tháng năm sinh. Định dạng YYYY-MM',
  `namsinh` VARCHAR(4) COMMENT 'Năm sinh. Định dạng YYYY',
  `dantoc` VARCHAR(3) NOT NULL COMMENT 'Dân tộc theo danh mục quy định tại phụ lục của tài liệu',
  `quoctich` VARCHAR(2) NOT NULL COMMENT 'Quốc tịch theo danh mục quy định tại phụ lục của tài liệu',
  `noisinhdiachichitiet` VARCHAR(250) COMMENT 'Địa chỉ chi tiết',
  `noisinh_maxa` VARCHAR(5) COMMENT 'Mã xã, phường, thị trấn theo danh mục quy định tại Quyết định 19/2025/QĐ-TTg',
  `noisinh_matinh` VARCHAR(2) COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo danh mục quy định tại Quyết định 19/2025/QĐ-TTg',
  `noisinh_quocgia` VARCHAR(3) COMMENT 'Mã quốc gia của địa chỉ theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientaidiachichitiet` VARCHAR(250) COMMENT 'Địa chỉ chi tiết',
  `noiohientai_maxa` VARCHAR(5) COMMENT 'Mã xã, phường, thị trấn theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_matinh` VARCHAR(2) COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_quocgia` VARCHAR(3) COMMENT 'Mã quốc gia của địa chỉ theo danh mục quy định tại phụ lục của tài liệu',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx_nguoivn`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_nguoivn_keythongtinhocsinhca` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx`) REFERENCES `thongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  KEY `idx_gioitinh` (`gioitinh`),
  KEY `idx_dantoc` (`dantoc`),
  KEY `idx_quoctich` (`quoctich`),
  KEY `idx_noisinh_maxa` (`noisinh_maxa`),
  KEY `idx_noisinh_matinh` (`noisinh_matinh`),
  KEY `idx_noisinh_quocgia` (`noisinh_quocgia`),
  KEY `idx_noiohientai_maxa` (`noiohientai_maxa`),
  KEY `idx_noiohientai_matinh` (`noiohientai_matinh`),
  KEY `idx_noiohientai_quocgia` (`noiohientai_quocgia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn` (
  `keythongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx_nguoivn` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `loaigiayto` VARCHAR(2) NOT NULL COMMENT 'Loại giấy tờ cá nhân theo danh mục 
- 1: Giấy khai sinh 
- 2: Chứng minh nhân dân 
- 3: Giấy chứng minh sỹ quan quân đội nhân dân Việt Nam 
- 4: Giấy chứng minh công an nhân dân 
- 5: Căn cước công dân 
- 6: Hộ chiếu 
- 7: Số hộ khẩu 
- 8: Các loại giấy tờ tùy thân khác',
  `sogiayto` VARCHAR(30) NOT NULL COMMENT 'Số giấy tờ',
  `ngaycap` DATE COMMENT 'Ngày cấp giấy tờ. Định dạng YYYY-MM-DD',
  `noicap` VARCHAR(300) COMMENT 'Nơi cấp giấy tờ',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx_nguoivn` (`keythongtinhocsinhcapmnththcsthpttx_nguoivn`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_nguoivn_giaytodinhdanhcn_key` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx_nguoivn`) REFERENCES `thongtinhocsinhcapmnththcsthpttx_nguoivn` (`keythongtinhocsinhcapmnththcsthpttx_nguoivn`),
  KEY `idx_loaigiayto` (`loaigiayto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai` (
  `keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `sodinhdanh` VARCHAR(12) COMMENT 'Số định danh người nước ngoài',
  `sogiaytoxnc` VARCHAR(50) COMMENT 'Số giấy tờ của người nước ngoài được sử dụng nhập cảnh vào Việt Nam',
  `hotennn` VARCHAR(150) NOT NULL COMMENT 'Họ và tên',
  `gioitinhnn` VARCHAR(1) NOT NULL COMMENT 'Giới tính theo danh mục quy định tại phụ lục của tài liệu:
0 - Chưa có thông tin
1 - Giới tính nam
2 - Giới tính nữ',
  `ngaythangnamsinh` DATE COMMENT 'Ngày tháng năm sinh. Định dạng YYYY-MM-DD',
  `thangnamsinh` VARCHAR(7) COMMENT 'Tháng năm sinh. Định dạng YYYY-MM',
  `namsinh` VARCHAR(4) COMMENT 'Năm sinh. Định dạng YYYY',
  `quoctichnn` VARCHAR(2) NOT NULL COMMENT 'Quốc tịch theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_diachichitiet` VARCHAR(250) COMMENT 'Địa chỉ chi tiết',
  `noiohientai_maxa` VARCHAR(5) COMMENT 'Mã xã, phường, thị trấn theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_matinh` VARCHAR(2) COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_quocgia` VARCHAR(3) COMMENT 'Mã quốc gia của địa chỉ theo danh mục quy định tại phụ lục của tài liệu',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_keythongtin` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx`) REFERENCES `thongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  KEY `idx_gioitinhnn` (`gioitinhnn`),
  KEY `idx_quoctichnn` (`quoctichnn`),
  KEY `idx_noiohientai_maxa` (`noiohientai_maxa`),
  KEY `idx_noiohientai_matinh` (`noiohientai_matinh`),
  KEY `idx_noiohientai_quocgia` (`noiohientai_quocgia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhdanh`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhdanh` (
  `keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhd` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `loaigiaytoxnc` VARCHAR(2) COMMENT 'Loại giấy tờ cá nhân theo danh mục 
- 1: Giấy khai sinh 
- 2: Chứng minh nhân dân 
- 3: Giấy chứng minh sỹ quan quân đội nhân dân Việt Nam 
- 4: Giấy chứng minh công an nhân dân 
- 5: Căn cước công dân 
- 6: Hộ chiếu 
- 7: Số hộ khẩu 
- 8: Các loại giấy tờ tùy thân khác',
  `sogiaytoxnc` VARCHAR(50) COMMENT 'Số giấy tờ',
  `noicapgiaytoxnc` VARCHAR(300) COMMENT 'Ngày cấp giấy tờ. Định dạng YYYY-MM-DD',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhd`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai` (`keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_congdannuocngoai_giaytodinhd` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai`) REFERENCES `thongtinhocsinhcapmnththcsthpttx_congdannuocngoai` (`keythongtinhocsinhcapmnththcsthpttx_congdannuocngoai`),
  KEY `idx_loaigiaytoxnc` (`loaigiaytoxnc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_thongtincha`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_thongtincha` (
  `keythongtinhocsinhcapmnththcsthpttx_thongtincha` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `hovaten` VARCHAR(150) NOT NULL COMMENT 'Tên cha',
  `sodinhdanh` VARCHAR(12) NOT NULL COMMENT 'Số định danh của cha',
  `nghenghiep` VARCHAR(100) COMMENT 'Nghề nghiệp cha',
  `namsinh` VARCHAR(4) NOT NULL COMMENT 'Năm sinh cha. Định dạng YYYY',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx_thongtincha`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_thongtincha_keythongtinhocsi` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx`) REFERENCES `thongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_thongtinme`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_thongtinme` (
  `keythongtinhocsinhcapmnththcsthpttx_thongtinme` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `hovaten` VARCHAR(150) NOT NULL COMMENT 'Tên cha',
  `sodinhdanh` VARCHAR(12) NOT NULL COMMENT 'Số định danh của mẹ',
  `nghenghiep` VARCHAR(100) COMMENT 'Nghề nghiệp cha',
  `namsinh` VARCHAR(4) NOT NULL COMMENT 'Năm sinh cha. Định dạng YYYY',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx_thongtinme`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_thongtinme_keythongtinhocsin` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx`) REFERENCES `thongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_nguoidodau`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_nguoidodau` (
  `thongtinhocsinhcapmnththcsthpttx_nguoidodau` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `hovaten` VARCHAR(150) NOT NULL COMMENT 'Tên cha',
  `sodinhdanh` VARCHAR(12) NOT NULL COMMENT 'Số định danh của người đỡ đầu',
  `nghenghiep` VARCHAR(250) COMMENT 'Nghề nghiệp cha',
  `namsinh` VARCHAR(4) NOT NULL COMMENT 'Năm sinh cha. Định dạng YYYY',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`thongtinhocsinhcapmnththcsthpttx_nguoidodau`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_nguoidodau_keythongtinhocsin` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx`) REFERENCES `thongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinhocsinhcapmnththcsthpttx_khenthuong`;
CREATE TABLE `thongtinhocsinhcapmnththcsthpttx_khenthuong` (
  `keythongtinhocsinhcapmnththcsthpttx_khenthuong` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinhocsinhcapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `makhenthuong` VARCHAR(20) NOT NULL COMMENT 'Mã khen thưởng theo danh mục',
  `noidung` VARCHAR(255) NOT NULL COMMENT 'Nội dung khen thưởng',
  `monkhenthuong` VARCHAR(150) NOT NULL COMMENT 'Môn khen thưởng',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinhocsinhcapmnththcsthpttx_khenthuong`),
  KEY `idx_keythongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  CONSTRAINT `fk_thongtinhocsinhcapmnththcsthpttx_khenthuong_keythongtinhocsin` FOREIGN KEY (`keythongtinhocsinhcapmnththcsthpttx`) REFERENCES `thongtinhocsinhcapmnththcsthpttx` (`keythongtinhocsinhcapmnththcsthpttx`),
  KEY `idx_makhenthuong` (`makhenthuong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtindoingucanbocsgdcapmamnonththcsthpttx`;
CREATE TABLE `thongtindoingucanbocsgdcapmamnonththcsthpttx` (
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường',
  `magiaovien` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên',
  `matrangthailv` VARCHAR(20) NOT NULL COMMENT 'Mã trạng thái làm việc của cán bộ theo danh mục của bộ ngành',
  `sodienthoai` VARCHAR(20) NOT NULL COMMENT 'Số điện thoại',
  `email` VARCHAR(50) NOT NULL COMMENT 'Email',
  `codangvien` VARCHAR(1) NOT NULL COMMENT 'Là đảng viên không
0: Không
1: Có',
  `codoanvien` VARCHAR(1) NOT NULL COMMENT 'Là đoàn viên không
0: Không
1: Có',
  `masobhxh` VARCHAR(15) NOT NULL COMMENT 'Mã sổ bảo hiểm xã hội',
  `manhomcanbo` VARCHAR(20) NOT NULL COMMENT 'Mã nhóm cán bộ theo danh mục của bộ ngành',
  `maloaicanbo` VARCHAR(20) NOT NULL COMMENT 'Mã loại cán bộ theo danh mục của bộ ngành',
  `mahinhthuchopdong` VARCHAR(20) NOT NULL COMMENT 'Mã hình thức hợp đồng theo danh mục của bộ ngành',
  `ngaytuyendung` DATE NOT NULL COMMENT 'Ngày tuyển dụng. Định dạng YYYY-MM-DD',
  `coquantuyen` VARCHAR(100) NOT NULL COMMENT 'Cơ quan tuyển dụng',
  `nghenghiepkhituyen` VARCHAR(100) COMMENT 'Nghề nghiệp khi được tuyển',
  `mangach` VARCHAR(20) COMMENT 'Mã ngạch/ hạng theo danh mục của bộ ngành',
  `masongach` VARCHAR(20) COMMENT 'Mã số ngạch/hạng theo danh mục của bộ ngành',
  `matiengdantoc` VARCHAR(20) COMMENT 'Mã tiếng dân tộc theo danh mục của bộ ngành',
  `cotaphuankynangsong` VARCHAR(1) COMMENT 'Có được tập huấn kỹ năng sống, nhận 2 giá trị:
0: Không
1: Có',
  `codaylopkhuyettat` VARCHAR(1) COMMENT 'Có dạy lớp khuyết tật, nhận 2 giá trị:
0: Không
1: Có',
  `coday1buoi` VARCHAR(1) COMMENT 'Có dạy 1 buổi/ ngày, nhận 2 giá trị:
0: Không
1: Có',
  `coday2buoi` VARCHAR(1) COMMENT 'Có dạy 2 buổi/ ngày, nhận 2 giá trị:
0: Không
1: Có',
  `cochuyentrachdoandoi` VARCHAR(1) NOT NULL COMMENT 'Có chuyên trách đoàn đội, nhận 2 giá trị:
0: Không
1: Có',
  `maboiduongthuongxuyen` VARCHAR(20) COMMENT 'Mã bồi dưỡng thường xuyên theo danh mục của bộ ngành',
  `matrinhdochuyenmon` VARCHAR(20) NOT NULL COMMENT 'Mã trình độ chuyên môn theo danh mục của bộ ngành',
  `matrinhdolyluanchinhtri` VARCHAR(20) COMMENT 'Mã trình độ lý luận chính trị theo danh mục của bộ ngành',
  `matrinhdoquanlygiaoduc` VARCHAR(20) NOT NULL COMMENT 'Mã trình độ quản lý giáo dục theo danh mục của bộ ngành',
  `matrinhdotinhoc` VARCHAR(20) NOT NULL COMMENT 'Mã trình độ tin học theo danh mục của bộ ngành',
  `maketquachuannghenghiep` VARCHAR(20) COMMENT 'Mã kết quả chuẩn nghề nghiệp theo danh mục của bộ ngành',
  `madanhgiavienchuc` VARCHAR(20) NOT NULL COMMENT 'Mã đánh giá viên chức theo danh mục của bộ ngành',
  `magiaoviengioi` VARCHAR(20) COMMENT 'Mã giáo viên giỏi theo danh mục của bộ ngành',
  `loaigvgdvanhoa` VARCHAR(20) COMMENT 'Mã loại giáo viên giảng dạy văn hóa theo danh mục của bộ ngành',
  `danhhieuptcaonhat` VARCHAR(150) COMMENT 'Danh hiệu được phong tặng cao nhất',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`),
  KEY `idx_manhomcanbo` (`manhomcanbo`),
  KEY `idx_maloaicanbo` (`maloaicanbo`),
  KEY `idx_mahinhthuchopdong` (`mahinhthuchopdong`),
  KEY `idx_mangach` (`mangach`),
  KEY `idx_masongach` (`masongach`),
  KEY `idx_matiengdantoc` (`matiengdantoc`),
  KEY `idx_maboiduongthuongxuyen` (`maboiduongthuongxuyen`),
  KEY `idx_matrinhdochuyenmon` (`matrinhdochuyenmon`),
  KEY `idx_matrinhdolyluanchinhtri` (`matrinhdolyluanchinhtri`),
  KEY `idx_matrinhdoquanlygiaoduc` (`matrinhdoquanlygiaoduc`),
  KEY `idx_matrinhdotinhoc` (`matrinhdotinhoc`),
  KEY `idx_maketquachuannghenghiep` (`maketquachuannghenghiep`),
  KEY `idx_madanhgiavienchuc` (`madanhgiavienchuc`),
  KEY `idx_magiaoviengioi` (`magiaoviengioi`),
  KEY `idx_loaigvgdvanhoa` (`loaigvgdvanhoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn`;
CREATE TABLE `thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn` (
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `sodinhdanh` VARCHAR(12) NOT NULL COMMENT 'Số định danh cá nhân',
  `hovaten` VARCHAR(150) NOT NULL COMMENT 'Họ, chữ đệm và tên khai sinh',
  `tenkhac` VARCHAR(150) COMMENT 'Tên viết tắt/Tên khác',
  `gioitinh` VARCHAR(2) NOT NULL COMMENT 'Giới tính theo danh mục:
0 - Chưa có thông tin
1 - Giới tính nam
2 - Giới tính nữ',
  `ngaythangnamsinh` DATE COMMENT 'Ngày tháng năm sinh. Định dạng YYYY-MM-DD',
  `thangnamsinh` VARCHAR(7) COMMENT 'Tháng năm sinh. Định dạng YYYY-MM',
  `namsinh` VARCHAR(4) COMMENT 'Năm sinh. Định dạng YYYY',
  `dantoc` VARCHAR(2) NOT NULL COMMENT 'Dân tộc theo danh mục quy định tại phụ lục của tài liệu',
  `quoctich` VARCHAR(2) NOT NULL COMMENT 'Quốc tịch theo danh mục quy định tại phụ lục của tài liệu',
  `quequan_diachichitiet` VARCHAR(255) COMMENT 'Địa chỉ chi tiết',
  `quequan_maxa` VARCHAR(5) NOT NULL COMMENT 'Mã xã, phường, thị trấn theo danh mục quy định tại phụ lục của tài liệu',
  `quequan_matinh` VARCHAR(2) NOT NULL COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo danh mục quy định tại phụ lục của tài liệu',
  `quequan_quocgia` VARCHAR(3) NOT NULL COMMENT 'Mã quốc gia của địa chỉ theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_diachichitiet` VARCHAR(255) COMMENT 'Địa chỉ chi tiết',
  `noiohientai_maxa` VARCHAR(5) NOT NULL COMMENT 'Mã xã, phường, thị trấn theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_matinh` VARCHAR(2) NOT NULL COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_quocgia` VARCHAR(3) NOT NULL COMMENT 'Mã quốc gia của địa chỉ theo danh mục quy định tại phụ lục của tài liệu',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn`),
  KEY `idx_keythongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  CONSTRAINT `fk_thongtindoingucanbocsgdcapmamnonththcsthpttx_nguoivn_keythong` FOREIGN KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`) REFERENCES `thongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  KEY `idx_gioitinh` (`gioitinh`),
  KEY `idx_dantoc` (`dantoc`),
  KEY `idx_quoctich` (`quoctich`),
  KEY `idx_quequan_maxa` (`quequan_maxa`),
  KEY `idx_quequan_matinh` (`quequan_matinh`),
  KEY `idx_quequan_quocgia` (`quequan_quocgia`),
  KEY `idx_noiohientai_maxa` (`noiohientai_maxa`),
  KEY `idx_noiohientai_matinh` (`noiohientai_matinh`),
  KEY `idx_noiohientai_quocgia` (`noiohientai_quocgia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai`;
CREATE TABLE `thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai` (
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `sodinhdanh` VARCHAR(12) COMMENT 'Số định danh người nước ngoài',
  `sogiaytoxnc` VARCHAR(50) COMMENT 'Số giấy tờ của người nước ngoài được sử dụng nhập cảnh vào Việt Nam',
  `hotennn` VARCHAR(150) NOT NULL COMMENT 'Họ và tên',
  `gioitinhnn` VARCHAR(2) NOT NULL COMMENT 'Giới tính theo danh mục quy định tại phụ lục của tài liệu:
0 - Chưa có thông tin
1 - Giới tính nam
2 - Giới tính nữ',
  `ngaythangnamsinh` DATE COMMENT 'Ngày tháng năm sinh. Định dạng YYYY-MM-DD',
  `thangnamsinh` VARCHAR(7) COMMENT 'Tháng năm sinh. Định dạng YYYY-MM',
  `namsinh` VARCHAR(4) COMMENT 'Năm sinh. Định dạng YYYY',
  `quoctichnn` VARCHAR(2) NOT NULL COMMENT 'Quốc tịch theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_diachichitiet` VARCHAR(255) COMMENT 'Địa chỉ chi tiết',
  `noiohientai_maxa` VARCHAR(5) NOT NULL COMMENT 'Mã xã, phường, thị trấn theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_matinh` VARCHAR(2) NOT NULL COMMENT 'Mã tỉnh, thành phố trực thuộc trung ương theo danh mục quy định tại phụ lục của tài liệu',
  `noiohientai_quocgia` VARCHAR(3) NOT NULL COMMENT 'Mã quốc gia của địa chỉ theo danh mục quy định tại phụ lục của tài liệu',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai`),
  KEY `idx_keythongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  CONSTRAINT `fk_thongtindoingucanbocsgdcapmamnonththcsthpttx_congdannuocngoai` FOREIGN KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`) REFERENCES `thongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  KEY `idx_gioitinhnn` (`gioitinhnn`),
  KEY `idx_quoctichnn` (`quoctichnn`),
  KEY `idx_noiohientai_maxa` (`noiohientai_maxa`),
  KEY `idx_noiohientai_matinh` (`noiohientai_matinh`),
  KEY `idx_noiohientai_quocgia` (`noiohientai_quocgia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtindoingucanbocsgdcapmamnonththcsthpttx_monday`;
CREATE TABLE `thongtindoingucanbocsgdcapmamnonththcsthpttx_monday` (
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx_monday` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `mamonday` VARCHAR(20) COMMENT 'Mã môn dạy theo danh mục của bộ ngành',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx_monday`),
  KEY `idx_keythongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  CONSTRAINT `fk_thongtindoingucanbocsgdcapmamnonththcsthpttx_monday_keythongt` FOREIGN KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`) REFERENCES `thongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  KEY `idx_mamonday` (`mamonday`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem`;
CREATE TABLE `thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem` (
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `mamonkiemnhiem` VARCHAR(20) COMMENT 'Mã môn kiêm nhiệm theo danh mục của bộ ngành',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem`),
  KEY `idx_keythongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  CONSTRAINT `fk_thongtindoingucanbocsgdcapmamnonththcsthpttx_monkiemnhiem_key` FOREIGN KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`) REFERENCES `thongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu`;
CREATE TABLE `thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu` (
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtindoingucanbocsgdcapmamnonththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `mangoaingu` VARCHAR(20) NOT NULL COMMENT 'Mã ngoại ngữ theo danh mục của bộ ngành',
  `trinhdongoaingu` VARCHAR(20) NOT NULL COMMENT 'Mã trình độ ngoại ngữ theo danh mục của bộ ngành',
  `diemngoaingu` DOUBLE COMMENT 'Điểm ngoại ngữ',
  `ngaycap` DATE COMMENT 'Ngày cấp theo định dạng YYYY-MM-DD',
  `ghichu` VARCHAR(200) COMMENT 'Ghi chú',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu`),
  KEY `idx_keythongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  CONSTRAINT `fk_thongtindoingucanbocsgdcapmamnonththcsthpttx_ngoaingu_keython` FOREIGN KEY (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`) REFERENCES `thongtindoingucanbocsgdcapmamnonththcsthpttx` (`keythongtindoingucanbocsgdcapmamnonththcsthpttx`),
  KEY `idx_mangoaingu` (`mangoaingu`),
  KEY `idx_trinhdongoaingu` (`trinhdongoaingu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinkhenthuonggiaoviencapmnththcsthpttx`;
CREATE TABLE `thongtinkhenthuonggiaoviencapmnththcsthpttx` (
  `keythongtinkhenthuonggiaoviencapmnththcsthpttx` VARCHAR(255) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường/Mã trung tâm. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT',
  `magiaovien` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ',
  `makhenthuonggv` VARCHAR(20) NOT NULL COMMENT 'Mã khen thưởng giáo viên theo danh mục của bộ ngành',
  `maloaikhenthuong` VARCHAR(20) NOT NULL COMMENT 'Mã Loại khen thưởng giáo viên theo danh mục của bộ ngành',
  `noidungkhenthuong` VARCHAR(250) NOT NULL COMMENT 'Nội dung khen thưởng giao viên',
  `capkhenthuong` VARCHAR(100) NOT NULL COMMENT 'Cấp khen thưởng giáo viên theo danh mục của bộ ngành',
  `ngaykhenthuong` DATE NOT NULL COMMENT 'Ngày khen thưởng. Định dạng YYYY-MM-DD',
  `soquyetdinh` VARCHAR(100) NOT NULL COMMENT 'Số quyết định',
  `nam` VARCHAR(4) NOT NULL COMMENT 'Năm quyết định. Định dạng YYYY',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinkhenthuonggiaoviencapmnththcsthpttx`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`),
  KEY `idx_makhenthuonggv` (`makhenthuonggv`),
  KEY `idx_maloaikhenthuong` (`maloaikhenthuong`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinkyluatgiaoviencapmnththcsthpttx`;
CREATE TABLE `thongtinkyluatgiaoviencapmnththcsthpttx` (
  `keythongtinkyluatgiaoviencapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường/Mã trung tâm. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT',
  `magiaovien` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ',
  `makyluatgv` VARCHAR(20) NOT NULL COMMENT 'Mã kỷ luật giáo viên theo danh mục của bộ ngành',
  `loaikyluat` VARCHAR(20) NOT NULL COMMENT 'Mã Loại kỷ luật theo danh mục của bộ ngành',
  `lydo` VARCHAR(100) NOT NULL COMMENT 'Lý do',
  `capkyluat` VARCHAR(100) NOT NULL COMMENT 'Cấp kỷ luật theo danh mục của bộ ngành',
  `ngaykyluat` DATE NOT NULL COMMENT 'Ngày kỷ luật. Định dạng YYYY-MM-DD',
  `soquyetdinh` VARCHAR(100) NOT NULL COMMENT 'Số quyết định',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinkyluatgiaoviencapmnththcsthpttx`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`),
  KEY `idx_makyluatgv` (`makyluatgv`),
  KEY `idx_loaikyluat` (`loaikyluat`),
  KEY `idx_capkyluat` (`capkyluat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx`;
CREATE TABLE `quatrinhdaotaoboiduonggiaoviencapmnththcsthpttx` (
  `keyquatrinhdaotaoboiduonggiaoviencapmnththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT',
  `tentruong` VARCHAR(150) NOT NULL COMMENT 'Tên trường',
  `magiaovien` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ',
  `manhomchuyennganh` VARCHAR(20) NOT NULL COMMENT 'Mã nhóm chuyên ngành theo danh mục của bộ ngành',
  `hinhthucdaotao` VARCHAR(20) NOT NULL COMMENT 'Mã hình thức đào tạo theo danh mục',
  `chuyennganh` VARCHAR(100) NOT NULL COMMENT 'Chuyên ngành đào tạo',
  `thoigiandaotao_tungay` DATE NOT NULL COMMENT 'Từ ngày tháng năm. Định dạng YYYY-MM-DD',
  `thoigiandaotao_denngay` DATE COMMENT 'Đến ngày tháng năm. Định dạng YYYY-MM-DD',
  `vanbangchungchi_ma` VARCHAR(50) COMMENT 'Mã văn bản chứng chỉ',
  `vanbangchungchi_ten` VARCHAR(100) NOT NULL COMMENT 'Tên văn bản chứng chỉ',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keyquatrinhdaotaoboiduonggiaoviencapmnththcsthpttx`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ketquahoctapththcsthpttx`;
CREATE TABLE `ketquahoctapththcsthpttx` (
  `keyketquahoctapththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 01: Mầm non
- 02: Tiểu học
- 03: Trung học cơ sở
- 04: Trung học phổ thông
- 05: Thường xuyên',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT',
  `makhoi` VARCHAR(20) NOT NULL COMMENT 'Tên trường',
  `malop` VARCHAR(20) NOT NULL COMMENT 'Mã lớp',
  `mahocsinh` VARCHAR(20) NOT NULL COMMENT 'Mã học sinh. Tham chiếu đến dữ liệu Học sinh Tiểu học - THCS - THPT',
  `hocky` VARCHAR(1) NOT NULL COMMENT 'Học kỳ',
  `diemtongket` DOUBLE NOT NULL COMMENT 'Điểm tổng kết',
  `mahocluc` VARCHAR(1) NOT NULL COMMENT 'Mã học lực theo danh mục quy định tại điều 9, Thông tư số 22/2021/TT-BGDĐT
1 - Tốt
2 - Khá
3 - Đạt
4 - Chưa đạt',
  `mahanhkiem` VARCHAR(1) NOT NULL COMMENT 'Mã hạnh kiểm theo danh mục quy định tại điều 8 Thông tư số 22/2021/TT-BGDĐT
1 - Mức tốt
2 - Mức khá
3 - Mức đạt
4 - Chưa đạt',
  `madanhhieu` VARCHAR(20) NOT NULL COMMENT 'Mã danh hiệu theo danh mục quy định tại Quyết định số 4998/QĐ-BGDĐT',
  `songaynghi` INT COMMENT 'Số ngày nghỉ',
  `nhanxet` VARCHAR(255) COMMENT 'Nhận xét',
  `colenlop` VARCHAR(1) NOT NULL COMMENT 'Được lên lớp
0 - Không
1 - Có',
  `corenluyenlai` VARCHAR(1) COMMENT 'Rèn luyện lại
0 - Không
1 - Có',
  `coduxettotnghiep` VARCHAR(1) COMMENT 'Được dự xét tốt nghiệp
0 - Không
1 - Có',
  `totnghiepcap` VARCHAR(150) COMMENT 'Tốt nghiệp cấp học',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keyketquahoctapththcsthpttx`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`),
  KEY `idx_mahocluc` (`mahocluc`),
  KEY `idx_mahanhkiem` (`mahanhkiem`),
  KEY `idx_madanhhieu` (`madanhhieu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ketquahoctapththcsthpttx_nguoivn`;
CREATE TABLE `ketquahoctapththcsthpttx_nguoivn` (
  `keytketquahoctapththcsthpttx_nguoivn` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keyketquahoctapththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `sodinhdanh` VARCHAR(12) NOT NULL COMMENT 'Số định danh cá nhân',
  `hovaten` VARCHAR(150) NOT NULL COMMENT 'Họ, chữ đệm và tên khai sinh',
  `ngaythangnamsinh` DATE COMMENT 'Ngày tháng năm sinh. Định dạng YYYY-MM-DD',
  `thangnamsinh` VARCHAR(7) COMMENT 'Tháng năm sinh. Định dạng YYYY-MM',
  `namsinh` VARCHAR(4) COMMENT 'Năm sinh. Định dạng YYYY',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keytketquahoctapththcsthpttx_nguoivn`),
  KEY `idx_keyketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`),
  CONSTRAINT `fk_ketquahoctapththcsthpttx_nguoivn_keyketquahoctapththcsthpttx` FOREIGN KEY (`keyketquahoctapththcsthpttx`) REFERENCES `ketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ketquahoctapththcsthpttx_cogndannuocngoai`;
CREATE TABLE `ketquahoctapththcsthpttx_cogndannuocngoai` (
  `keytketquahoctapththcsthpttx_cogndannuocngoai` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keyketquahoctapththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `sodinhdanh` VARCHAR(12) COMMENT 'Số định danh người nước ngoài',
  `sogiaytoxnc` VARCHAR(50) COMMENT 'Số giấy tờ của người nước ngoài được sử dụng nhập cảnh vào Việt Nam',
  `hotennn` VARCHAR(150) NOT NULL COMMENT 'Họ và tên',
  `ngaythangnamsinhnn` DATE COMMENT 'Ngày tháng năm sinh. Định dạng YYYY-MM-DD',
  `thangnamsinhnn` VARCHAR(7) COMMENT 'Tháng năm sinh. Định dạng YYYY-MM',
  `namsinhnn` VARCHAR(4) COMMENT 'Năm sinh. Định dạng YYYY',
  `quoctichnn` VARCHAR(2) NOT NULL COMMENT 'Quốc tịch theo danh mục quy định tại phụ lục của tài liệu',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keytketquahoctapththcsthpttx_cogndannuocngoai`),
  KEY `idx_keyketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`),
  CONSTRAINT `fk_ketquahoctapththcsthpttx_cogndannuocngoai_keyketquahoctapthth` FOREIGN KEY (`keyketquahoctapththcsthpttx`) REFERENCES `ketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`),
  KEY `idx_quoctichnn` (`quoctichnn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ketquahoctapththcsthpttx_khenthuong`;
CREATE TABLE `ketquahoctapththcsthpttx_khenthuong` (
  `keyketquahoctapththcsthpttx_khenthuong` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keyketquahoctapththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `khenthuong` VARCHAR(255) NOT NULL COMMENT 'Khen thưởng',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keyketquahoctapththcsthpttx_khenthuong`),
  KEY `idx_keyketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`),
  CONSTRAINT `fk_ketquahoctapththcsthpttx_khenthuong_keyketquahoctapththcsthpt` FOREIGN KEY (`keyketquahoctapththcsthpttx`) REFERENCES `ketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ketquahoctapththcsthpttx_kyluat`;
CREATE TABLE `ketquahoctapththcsthpttx_kyluat` (
  `keyketquahoctapththcsthpttx_kyluat` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keyketquahoctapththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `kyluat` VARCHAR(255) NOT NULL COMMENT 'Thông tin Kỷ luật',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keyketquahoctapththcsthpttx_kyluat`),
  KEY `idx_keyketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`),
  CONSTRAINT `fk_ketquahoctapththcsthpttx_kyluat_keyketquahoctapththcsthpttx` FOREIGN KEY (`keyketquahoctapththcsthpttx`) REFERENCES `ketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ketquahoctapththcsthpttx_diemmon`;
CREATE TABLE `ketquahoctapththcsthpttx_diemmon` (
  `keyketquahoctapththcsthpttx_diemmon` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keyketquahoctapththcsthpttx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `mamonhoc` VARCHAR(20) NOT NULL COMMENT 'Mã môn học theo danh mục quy định tại Quyết định số 4998/QĐ-BGDĐT',
  `diem` DOUBLE NOT NULL COMMENT 'Điểm',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keyketquahoctapththcsthpttx_diemmon`),
  KEY `idx_keyketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`),
  CONSTRAINT `fk_ketquahoctapththcsthpttx_diemmon_keyketquahoctapththcsthpttx` FOREIGN KEY (`keyketquahoctapththcsthpttx`) REFERENCES `ketquahoctapththcsthpttx` (`keyketquahoctapththcsthpttx`),
  KEY `idx_mamonhoc` (`mamonhoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinlophoctieuhoc`;
CREATE TABLE `thongtinlophoctieuhoc` (
  `keythongtinlophoctieuhoc` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT',
  `malop` VARCHAR(20) NOT NULL COMMENT 'Mã lớp',
  `tenlop` VARCHAR(150) NOT NULL COMMENT 'Tên lớp',
  `giaoviencn` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên chủ nhiệm. Tham chiếu đến dữ liệu Đội ngũ cán bộ',
  `makhoi` VARCHAR(20) NOT NULL COMMENT 'Mã khối theo danh mục của bộ ngành',
  `madiemtruong` VARCHAR(20) NOT NULL COMMENT 'Mã điểm trường',
  `danhmuctiethoc` VARCHAR(20) NOT NULL COMMENT 'Mã danh mục tiết học theo danh mục của bộ ngành',
  `madanhmucngoaingu1` VARCHAR(20) NOT NULL COMMENT 'Mã ngoại ngữ 1 theo danh mục của bộ ngành',
  `madanhmucngoaingu2` VARCHAR(20) COMMENT 'Mã ngoại ngữ 2 theo danh mục của bộ ngành',
  `masotietngoaingu` VARCHAR(20) COMMENT 'Mã số tiết ngoại ngữ theo danh mục của bộ ngành',
  `coday2buoingay` VARCHAR(1) NOT NULL COMMENT 'Dạy 2 buổi / ngày
0 - Không
1 - Có',
  `colopghep` VARCHAR(1) COMMENT 'Là lớp ghép
0 - Không
1 - Có',
  `malopghep` VARCHAR(15) COMMENT 'Mã lớp ghép',
  `cocapnhatlopghep` BOOLEAN COMMENT 'Có cập nhật lớp ghép
0 - Không
1 - Có',
  `colopbantru` BOOLEAN NOT NULL COMMENT 'Là lớp bán trú
0 - Không
1 - Có',
  `colopchuyenbiet` BOOLEAN NOT NULL COMMENT 'Là lớp chuyên biệt
0 - Không
1 - Có',
  `cohoc5buoituan` BOOLEAN NOT NULL COMMENT 'Là lớp học 5 buổi / tuần
0 - Không
1 - Có',
  `cohoc6den8buoituan` BOOLEAN NOT NULL COMMENT 'Là lớp học 6-8 buổi / tuần
0 - Không
1 - Có',
  `cohoc9den10buoituan` BOOLEAN NOT NULL COMMENT 'Là lớp học 9-10 buổi / tuần
0 - Không
1 - Có',
  `cocohocsinhhocnghe` BOOLEAN NOT NULL COMMENT 'Có học sinh học nghề
0 - Không
1 - Có',
  `coduthietbihoctv` BOOLEAN NOT NULL COMMENT 'Đủ thiết bị dạy học - Tiếng Việt
0 - Không
1 - Có',
  `coduthietbihoctoan` BOOLEAN NOT NULL COMMENT 'Đủ thiết bị dạy học - Toán
0 - Không
1 - Có',
  `codaidienchamehslop` BOOLEAN NOT NULL COMMENT 'Có đại diện cha mẹ học sinh lớp
0 - Không
1 - Có',
  `codaidienchamehstruong` BOOLEAN NOT NULL COMMENT 'Có đại diện cha mẹ học sinh trường
0 - Không
1 - Có',
  `mahocbantru` VARCHAR(20) COMMENT 'Mã học bán trú theo danh mục của bộ ngành',
  `masobuoihoctrentuan` VARCHAR(20) COMMENT 'Mã số buổi học trên tuần theo danh mục của bộ ngành',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinlophoctieuhoc`),
  KEY `idx_makhoi` (`makhoi`),
  KEY `idx_danhmuctiethoc` (`danhmuctiethoc`),
  KEY `idx_madanhmucngoaingu1` (`madanhmucngoaingu1`),
  KEY `idx_madanhmucngoaingu2` (`madanhmucngoaingu2`),
  KEY `idx_masotietngoaingu` (`masotietngoaingu`),
  KEY `idx_mahocbantru` (`mahocbantru`),
  KEY `idx_masobuoihoctrentuan` (`masobuoihoctrentuan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cosovatchatphonghoctieuhoc`;
CREATE TABLE `cosovatchatphonghoctieuhoc` (
  `keycosovatchatphonghoctieuhoc` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường tiểu học. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT',
  `madiemtruong` VARCHAR(20) NOT NULL COMMENT 'Mã điểm trường. Tham chiếu đến dữ liệu điểm trường',
  `mabaocao` VARCHAR(50) NOT NULL COMMENT 'Mã báo cáo',
  `noidungtieuchi` VARCHAR(500) NOT NULL COMMENT 'Nội dung tiêu chí',
  `soluongtrencap4` INT NOT NULL COMMENT 'Số lượng phòng học/công trình trên cấp 4',
  `dientichtrencap4` DOUBLE NOT NULL COMMENT 'Diện tích phòng học/công trình trên cấp 4',
  `soluongcap4` INT NOT NULL COMMENT 'Số lượng phòng học/công trình cấp 4',
  `dientichcap4` DOUBLE NOT NULL COMMENT 'Diện tích phòng học/công trình cấp 4',
  `soluongduoicap4` INT NOT NULL COMMENT 'Số lượng phòng học/công trình dưới cấp 4',
  `dientichduoicap4` DOUBLE NOT NULL COMMENT 'Diện tích phòng học/công trình dưới cấp 4',
  `soluong` INT NOT NULL COMMENT 'Số lượng phòng học/công trình',
  `dientich` DOUBLE NOT NULL COMMENT 'Diện tích phòng học/công trình',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keycosovatchatphonghoctieuhoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinlophocthcsthpt`;
CREATE TABLE `thongtinlophocthcsthpt` (
  `keythongtinlophocthcsthpt` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `manhomcaphoc` VARCHAR(2) NOT NULL COMMENT 'Mã nhóm cấp học theo danh mục của bộ ngành
- 03: Trung học cơ sở
- 04: Trung học phổ thông',
  `matruong` VARCHAR(20) NOT NULL COMMENT 'Mã trường. Tham chiếu đến dữ liệu Trường Tiểu học - THCS - THPT',
  `malop` VARCHAR(20) NOT NULL COMMENT 'Mã lớp',
  `tenlop` VARCHAR(150) NOT NULL COMMENT 'Tên lớp',
  `magiaoviencn` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ',
  `makhoi` VARCHAR(10) NOT NULL COMMENT 'Mã khối theo danh mục của bộ ngành',
  `madiemtruong` VARCHAR(20) NOT NULL COMMENT 'Mã điểm trường. Tham chiếu đến dữ liệu Danh sách điểm trường',
  `madanhmucngoaingu1` VARCHAR(20) NOT NULL COMMENT 'Mã ngoại ngữ 1 theo danh mục của bộ ngành',
  `madanhmucngoaingu2` VARCHAR(20) COMMENT 'Mã ngoại ngữ 2 theo danh mục của bộ ngành',
  `comaday2buoingay` BOOLEAN COMMENT 'Dạy 2 buổi / ngày
0 - Không
1 - Có',
  `comalopghep` BOOLEAN COMMENT 'Là lớp ghép
0 - Không
1 - Có',
  `malopghep` VARCHAR(20) COMMENT 'Mã lớp ghép',
  `comacapnhatlopghep` BOOLEAN COMMENT 'Có cập nhật lớp ghép
0 - Không
1 - Có',
  `comalopbantru` BOOLEAN COMMENT 'Là lớp bán trú
0 - Không
1 - Có
Nhóm cấp học THPT không có thông tin này',
  `comahoc5buoituan` BOOLEAN COMMENT 'Là lớp học 5 buổi / tuần
0 - Không
1 - Có',
  `comahocsinhhocnghe` BOOLEAN COMMENT 'Có học sinh học nghề
0 - Không
1 - Có',
  `mahocbantru` VARCHAR(150) COMMENT 'Mã học bán trú theo danh mục của bộ ngành
Nhóm cấp học THPT không có thông tin này',
  `masobuoihoctrentuan` VARCHAR(150) COMMENT 'Mã số buổi học trên tuần theo danh mục của bộ ngành',
  `comahskhuyettat` BOOLEAN COMMENT 'Lớp có học sinh khuyết tật
0 - Không
1 - Có',
  `comadaidienchamehslop` BOOLEAN COMMENT 'Có đại diện cha mẹ học sinh lớp
0 - Không
1 - Có',
  `comadaidienchamehstruong` BOOLEAN COMMENT 'Có đại diện cha mẹ học sinh trường
0 - Không
1 - Có',
  `maphanban` VARCHAR(20) NOT NULL COMMENT 'Mã phân ban theo danh mục của bộ ngành
Nhóm cấp học THCS không có thông tin này',
  `mahechuyen` VARCHAR(20) NOT NULL COMMENT 'Mã hệ chuyên theo danh mục của bộ ngành
Nhóm cấp học THCS không có thông tin này',
  `colopchuyen` BOOLEAN COMMENT 'Là lớp chuyện
0 - Không
1 - Có
Nhóm cấp học THCS không có thông tin này',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinlophocthcsthpt`),
  KEY `idx_manhomcaphoc` (`manhomcaphoc`),
  KEY `idx_makhoi` (`makhoi`),
  KEY `idx_madanhmucngoaingu1` (`madanhmucngoaingu1`),
  KEY `idx_madanhmucngoaingu2` (`madanhmucngoaingu2`),
  KEY `idx_mahocbantru` (`mahocbantru`),
  KEY `idx_maphanban` (`maphanban`),
  KEY `idx_mahechuyen` (`mahechuyen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinlophocthcsthpt_monhoc`;
CREATE TABLE `thongtinlophocthcsthpt_monhoc` (
  `keythongtinlophocthcsthpt_monhoc` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinlophocthcsthpt` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `mamonhoc` VARCHAR(15) NOT NULL COMMENT 'Mã môn học theo danh mục của bộ ngành',
  `hocky` INT NOT NULL COMMENT 'Học kỳ',
  `magiaovien` VARCHAR(15) NOT NULL COMMENT 'Mã giáo viên. Tham chiếu đến dữ liệu Đội ngũ cán bộ',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinlophocthcsthpt_monhoc`, `keythongtinlophocthcsthpt`),
  KEY `idx_mamonhoc` (`mamonhoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr`;
CREATE TABLE `cosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvacactr` (
  `keycosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvaca` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keycosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvaca` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `mavungkhokhan` VARCHAR(2) NOT NULL COMMENT 'Mã vùng khó khăn theo quy định tại Quyết định số 4998/QĐBGDĐT',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keycosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvaca`),
  KEY `idx_keycosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyen` (`keycosogiaoducthuongxuyengiaoducnghenghiepgiaoducthuongxuyenvaca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `decimal__20`;
CREATE TABLE `decimal__20` (
  `x` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinlophocgdtx`;
CREATE TABLE `thongtinlophocgdtx` (
  `keythongtinlophocgdtx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `matrungtam` VARCHAR(20) NOT NULL COMMENT 'Mã trung tâm. Tham chiếu đến dữ liệu Cơ sở giáo dục thường xuyên',
  `malop` VARCHAR(20) NOT NULL COMMENT 'Mã lớp',
  `tenlop` VARCHAR(150) NOT NULL COMMENT 'Tên lớp',
  `magiaoviencn` VARCHAR(20) NOT NULL COMMENT 'Mã giáo viên chủ nhiệm. Tham chiếu đến dữ liệu Đội ngũ cán bộ',
  `makhoi` VARCHAR(20) NOT NULL COMMENT 'Mã khối theo danh mục của bộ ngành',
  `makieulop` VARCHAR(20) NOT NULL COMMENT 'Mã kiểu lớp theo danh mục của bộ ngành',
  `hinhthuchoctap` VARCHAR(20) NOT NULL COMMENT 'Hình thức học tập theo danh mục quy định tại Quyết định số 4998/QĐBGDĐT',
  `malopdaotaoboiduong` VARCHAR(20) COMMENT 'Mã lớp đào tạo bồi dưỡng theo danh mục của bộ ngành',
  `malophuongnghiepdaynghe` VARCHAR(20) COMMENT 'Mã lớp hướng nghiệp dạy nghề theo danh mục của bộ ngành',
  `codaidienchamehslop` BOOLEAN COMMENT 'Có đại diện cha mẹ học sinh lớp
0 - Không
1 - Có',
  `codaidienchamehstruong` BOOLEAN COMMENT 'Có đại diện cha mẹ học sinh trường
0 - Không
1 - Có',
  `colopcohskhuyettat` BOOLEAN COMMENT 'Lớp có học sinh khuyết tật
0 - Không
1 - Có',
  `masobuoihoctrentuan` VARCHAR(15) NOT NULL COMMENT 'Mã số buổi học trên tuần theo danh mục của bộ ngành',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinlophocgdtx`),
  KEY `idx_makhoi` (`makhoi`),
  KEY `idx_makieulop` (`makieulop`),
  KEY `idx_hinhthuchoctap` (`hinhthuchoctap`),
  KEY `idx_malopdaotaoboiduong` (`malopdaotaoboiduong`),
  KEY `idx_malophuongnghiepdaynghe` (`malophuongnghiepdaynghe`),
  KEY `idx_masobuoihoctrentuan` (`masobuoihoctrentuan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `thongtinlophocgdtx_monhoc`;
CREATE TABLE `thongtinlophocgdtx_monhoc` (
  `keythongtinlophocgdtx_monhoc` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `keythongtinlophocgdtx` VARCHAR(32) NOT NULL COMMENT 'Key kỹ thuật, sử dụng để mapping nghiệp vụ hệ thống',
  `mamonhoc` VARCHAR(15) NOT NULL COMMENT 'Mã môn học theo danh mục của bộ ngành',
  `magiaovien` VARCHAR(15) NOT NULL COMMENT 'Mã giáo viên 
Tham chiếu thông tin đội ngũ cán bộ',
  `idbanghi` VARCHAR(150) NOT NULL COMMENT 'ID bản ghi là duy nhất, TTDLQG sử dụng IdBanGhi là khóa chính cho quá trình xử lý dữ liệu.

Bộ nghành có thể sử dụng thông tin MaTruong làm IdBanGhi',
  `sukien` VARCHAR(10) NOT NULL COMMENT 'Mã sự kiện nhằm phân loại trạng thái dữ liệu tại BNĐP là được thêm mới, cập nhật thông tin hoặc xóa, cụ thể tại TTDLQG quy ước:
- NEW: Thêm mới
- UPdate: Cập nhật
- CANCEL: Hủy (mềm)',
  `phienban` INT NOT NULL COMMENT 'Là số nguyên khác 0. BNĐP có trách nhiệm tăng số PhienBan khi gửi dữ liệu. TTDLQG dựa trên thông tin SuKien và PhienBan nhận được để thực hiện cập nhật dữ liệu có phiên bản lớn nhất và không xử lý với trường hợp PhienBan nhỏ hơn hoặc bằng PhienBan lớn nhất tại TTDLQG.',
  `thoigiancapnhat` DATETIME NOT NULL COMMENT 'Thời gian dữ liệu được cập nhật vào hệ thống của BNĐP: 
- Trường hợp SuKien là NEW: là thời gian thêm mới dữ liệu vào hệ thống của BNĐP. 
- Trường hợp SuKien là UPdate: là thời gian gần nhất mà bản ghi được chỉnh sửa hoặc thay đổi thông tin trong hệ thống tại BNĐP. 
Định dạng YYYY-MM-DDTHH:mm:ss',
  `ngaycapnhat` DATETIME NOT NULL COMMENT 'Ngày ghi dữ liệu vào hệ thống',
  PRIMARY KEY (`keythongtinlophocgdtx_monhoc`),
  KEY `idx_keythongtinlophocgdtx` (`keythongtinlophocgdtx`),
  CONSTRAINT `fk_thongtinlophocgdtx_monhoc_keythongtinlophocgdtx` FOREIGN KEY (`keythongtinlophocgdtx`) REFERENCES `thongtinlophocgdtx` (`keythongtinlophocgdtx`),
  KEY `idx_mamonhoc` (`mamonhoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=1;
