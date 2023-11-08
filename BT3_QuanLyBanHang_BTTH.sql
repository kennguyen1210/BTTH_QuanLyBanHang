create database QuanLyBanHang3;
use QuanLyBanHang3;
create table KHACHHANG(
	MaKH varchar(4) primary key,
    TenKH varchar(30) not null,
    DiaChi varchar(50),
    Ngaysinh datetime,
    SoDT varchar(15) unique
);
create table NHANVIEN(
	MaNV varchar(4) primary key,
    HoTen varchar(30) not null,
    GioiTinh bit not null,
    DiaChi varchar(50) not null,
    NgaySinh datetime not null,
    DienThoai varchar(15),
    Email text,
    NoiSinh varchar(20) not null,
    NgayVaoLam datetime,
    MaNQL varchar(4)
);
create table NHACUNGCAP(
	MaNCC varchar(5) primary key,
    TenNCC varchar(50) not null,
    DiaChi varchar(50) not null,
    DienThoai varchar(15) not null,
    Email varchar(30) not null,
    Website varchar(30)
);
create table LOAISP(
	MaloaiSP varchar(4) primary key,
    TenloaiSP varchar(30) not null,
    GhiChu varchar(100) not null
);
create table SANPHAM(
	MaSP varchar(4) primary key,
    MaloaiSP varchar(4) not null,
    TenSP varchar(50) not null,
    Donvitinh varchar(10) not null,
    GhiChu varchar(100)
);
create table PHIEUNHAP(
	SoPN varchar(5) primary key,
    MaNV varchar(4) not null,
    MaNCC varchar(5) not null,
    Ngaynhap datetime not null default now(),
    GhiChu varchar(100)
);
create table CTPHIEUNHAP(
	MaSP varchar(4) not null,
	SoPN varchar(5) not null,
    Soluong smallint not null default 0,
    Gianhap real not null check (Gianhap >= 0),
    primary key(MaSP, SoPN)
);
create table PHIEUXUAT(
	SoPX varchar(5) primary key,
    MaNV varchar(4) not null,
    MaKH varchar(4) not null,
    NgayBan datetime not null,
    GhiChu text
);
create table CTPHIEUXUAT(
	SoPX varchar(4) not null,
	MaSP varchar(5) not null,
    Soluong smallint not null check (Soluong > 0),
    GiaBan real not null check (GiaBan > 0),
    primary key(MaSP, SoPX)
);
-- bai tap 2 
alter table PHIEUNHAP 
add constraint FK_NhanVien foreign key(MaNV) references NHANVIEN(MaNV),
add constraint FK_NhaCungCap foreign key(MaNCC) references NHACUNGCAP(MaNCC);
alter table CTPHIEUNHAP 
add constraint FK_PhieuNhap foreign key(SoPN) references PHIEUNHAP(SoPN),
add constraint FK_SanPham foreign key(MaSP) references SANPHAM(MaSP);
alter table SANPHAM 
add constraint FK_LoaiSP foreign key(MaloaiSP) references LOAISP(MaloaiSP);
alter table PHIEUXUAT 
add constraint FK_NhanVienPX foreign key(MaNV) references NHANVIEN(MaNV),
add constraint FK_KhachHang foreign key(MaKH) references KHACHHANG(MaKH);
alter table CTPHIEUXUAT 
add constraint FK_PhieuXuat foreign key(SoPX) references PHIEUXUAT(SoPX),
add constraint FK_SanPhamCTPX foreign key(MaSP) references SANPHAM(MaSP);
-- ---------- 

INSERT INTO nhanvien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, manql)
VALUES
  ('NV01', 'Nguyen Van A', 1, '123 Nguyen Hue, TP.HCM', '1990-01-15', '0901234567', 'nv.a@example.com', 'TP.HCM', '2020-01-01 08:00:00', null),
  ('NV02', 'Tran Thi B', 0, '456 Le Loi, TP.HCM', '1995-05-20', '0912345678', 'tt.b@example.com', 'TP.HCM', '2021-03-15 09:30:00', 'NV02'),
  ('NV03', 'Pham Van C', 1, '789 Vo Van Tan, TP.HCM', '1988-11-02', '0987654321', 'pv.c@example.com', 'TP.HCM', '2019-10-10 07:45:00', 'NV02');
INSERT INTO khachhang (makh, tenkh, diachi, ngaysinh, sodt)
VALUES
  ('KH01', 'Nguyen Thi D', '101 Nguyen Trai, TP.HCM', '1985-12-25', '0978123456'),
  ('KH02', 'Tran Van E', '202 Le Lai, TP.HCM', '1992-08-10', '0987123456'),
  ('KH03', 'Le Thi F', '303 Vo Van Tan, TP.HCM', '1989-06-18', '0918123456');
INSERT INTO nhacungcap (mancc, tenncc, diachi, dienthoai, email, website)
VALUES
  ('NCC01', 'Cong ty A', '15 Le Duan, TP.HCM', '0909123456', 'info@ncc-a.com', 'www.ncc-a.com'),
  ('NCC02', 'Cong ty B', '25 Nguyen Thi Minh Khai, TP.HCM', '0918234567', 'info@ncc-b.com', 'www.ncc-b.com'),
  ('NCC03', 'Cong ty C', '35 Tran Hung Dao, TP.HCM', '0987654321', 'info@ncc-c.com', 'www.ncc-c.com');
INSERT INTO loaisp (maloaisp, tenloaisp, ghichu)
VALUES
  ('LSP1', 'Điện thoại di động', 'Các sản phẩm điện thoại di động'),
  ('LSP2', 'Laptop', 'Các sản phẩm laptop'),
  ('LSP3', 'Phụ kiện điện tử', 'Các phụ kiện điện tử');
INSERT INTO sanpham (masp, maloaisp, tensp, donvitinh, ghichu)
VALUES
  ('SP01', 'LSP1', 'iPhone 12', 'cái', 'Màu đen, bộ nhớ 128GB'),
  ('SP02', 'LSP1', 'Samsung Galaxy S21', 'cái', 'Màu xanh, bộ nhớ 256GB'),
  ('SP03', 'LSP2', 'Dell XPS 13', 'cái', 'Core i7, RAM 16GB');
INSERT INTO phieunhap (sopn, manv, mancc, ngaynhap, ghichu)
VALUES
  ('PN01', 'NV01', 'NCC01', '2023-07-10 10:30:00', 'Phiếu nhập số 1'),
  ('PN02', 'NV02', 'NCC02', '2023-07-15 15:45:00', 'Phiếu nhập số 2'),
  ('PN03', 'NV03', 'NCC03', '2023-07-20 09:00:00', 'Phiếu nhập số 3');
INSERT INTO ctphieunhap (masp, sopn, soluong, gianhap)
VALUES
  ('SP01', 'PN01', 50, 15000000),
  ('SP02', 'PN01', 30, 13000000),
  ('SP03', 'PN02', 20, 18000000),
  ('SP01', 'PN03', 40, 14500000);
INSERT INTO phieuxuat (sopx, manv, makh, ngayban, ghichu)
VALUES
  ('PX01', 'NV01', 'KH01', '2023-08-12 14:30:00', 'Phiếu xuất số 1'),
  ('PX02', 'NV02', 'KH02', '2023-08-18 10:15:00', 'Phiếu xuất số 2'),
  ('PX03', 'NV03', 'KH03', '2023-08-20 16:00:00', 'Phiếu xuất số 3');
INSERT INTO ctphieuxuat (sopx, masp, soluong, giaban)
VALUES
  ('PX01', 'SP01', 10, 20000000),
  ('PX01', 'SP02', 20, 18000000),
  ('PX02', 'SP03', 5, 22000000),
  ('PX03', 'SP01', 15, 19500000);
INSERT INTO sanpham (masp, maloaisp, tensp, donvitinh, ghichu)
VALUES
  ('SP04', 'LSP3', 'Man LCD 123', 'cái', 'Màn hình máy tính');
INSERT INTO sanpham (masp, maloaisp, tensp, donvitinh, ghichu)
VALUES
  ('SP05', 'LSP3', 'Bộ xử lý vi mạch', 'bộ', 'Thiết bị đính kèm');
INSERT INTO khachhang (makh, tenkh, diachi, ngaysinh, sodt)
VALUES
  ('KH04', 'Tran Van K', '111 Minh Khai, Ha Noi', '1990-11-20', '0903478888');
INSERT INTO nhacungcap (mancc, tenncc, diachi, dienthoai, email, website)
VALUES
  ('NCC04', 'Cong ty Z', '15 Phan Xich Long, TP.HCM', '0909865421', 'zcompany@ncc-a.com', 'www.ncc-zz.com');
INSERT INTO nhanvien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, manql)
VALUES
  ('NV05', 'Nguyen Thi X', 0, '320 Tan Binh, TP.HCM', '1994-05-15', '0904121131', 'nv.x@example.com', 'Soc Trang', '2019-05-20 08:00:00', 'NV02');
INSERT INTO nhanvien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, manql)
VALUES
  ('NV06', 'Le Duy V', 1, '123 Nguyen Chi Thanh, TP.HCM', '1963-01-15', '0348123456', 'nv.k@example.com', 'TP.HCM', '1990-12-01 08:00:00', 'NV02'),
  ('NV07', 'Tran Thi H', 0, '136 Ngo Quyen, TP.HCM', '1968-05-20', '0345456789', 'tt.h@example.com', 'TP.HCM', '1992-12-15 09:30:00', 'NV02');

-- bai tap 3 
-- them 1 nhan vien moi 
insert into nhanvien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, manql)
values ('NV04', 'Hau Xuan H', 0, '163 Nguyen Hue, Ha Noi', '1995-05-25', '0936845865', 'bxs.a@example.com', 'Thai Binh', '2019-03-20 10:00:00', 'NV02');

-- them 2 phieu nhap, moi phieu 2 san pham 
insert into phieunhap (sopn, manv, mancc, ngaynhap, ghichu)
values
	('PN04', 'NV02', 'NCC02', '2023-11-01 09:30:00', 'Phiếu nhập số 4'),
	('PN05', 'NV03', 'NCC01', '2023-11-03 10:00:00', 'Phiếu nhập số 5');
insert into ctphieunhap (masp, sopn, soluong, gianhap)
values 
	('SP01', 'PN04', 20, 15000000),
    ('SP03', 'PN04', 10, 15000000),
    ('SP02', 'PN05', 6, 12000000),
    ('SP01', 'PN05', 8, 14000000);
    
-- them 2 phieu xuat, moi phieu 3 san pham 
insert into phieuxuat (sopx, manv, makh, ngayban, ghichu)
values
	('PX04', 'NV02', 'KH02', '2023-11-03 14:30:00', 'Phiếu xuất số 4'),
	('PX05', 'NV03', 'KH01', '2023-11-03 10:30:00', 'Phiếu xuất số 5');
insert into ctphieuxuat (sopx, masp, soluong, giaban) 
values 
	('PX04', 'SP01', 10, 20000000),
    ('PX04', 'SP02', 5, 22000000),
    ('PX04', 'SP03', 5, 19000000),
    ('PX05', 'SP01', 5, 22000000),
    ('PX05', 'SP02', 3, 20000000),
    ('PX05', 'SP03', 4, 22000000);
	
-- bai tap 4
-- thay doi sodt cua khach hang KH03
update khachhang set SoDT = '0912456789' where MaKH = 'KH03'; 
-- thay doi diachi cua nhan vien NV03 
update nhanvien set DiaChi = '210 Truong Chinh, TP.HCM' where MaNV = 'NV03'; 

-- bai tap 5
-- xoa nhan vien moi them tai bai 3
delete from nhanvien where MaNV = 'NV04';

-- xoa san pham SP04
delete from sanpham where MaSP = 'SP04';

-- bai tap 6
-- 1
select MaNV, HoTen, GioiTinh, NgaySinh, DiaChi, DienThoai, year(now()) - year(NgaySinh) as Tuoi from nhanvien order by Tuoi;
-- 2
select pn.SoPN, pn.MaNV, nv.HoTen, ncc.TenNCC, pn.Ngaynhap, pn.GhiChu from ((phieunhap pn join nhanvien nv on pn.MaNV = nv.MaNV) join nhacungcap ncc on pn.MaNCC = ncc.MaNCC) where pn.Ngaynhap between '2023-07-01 00:00:00' and '2023-08-01 00:00:00';
-- 3
select * from sanpham where donvitinh = 'cái';
-- 4
select pn.SoPN, ctpn.MaSP, sp.TenSP, lsp.TenloaiSP, sp.DonviTinh, ctpn.SoLuong, ctpn.GiaNhap,ctpn.SoLuong * ctpn.GiaNhap as ThanhTien   
	from (((ctphieunhap ctpn
		join sanpham sp on ctpn.MaSP = sp.MaSP)
        join loaisp lsp on sp.MaloaiSP = lsp.MaloaiSP)
        join phieunhap pn on ctpn.SoPN = pn.SoPN)
	where pn.Ngaynhap between '2023-11-01 00:00:00' and '2023-12-01 00:00:00';
-- 5
select ncc.MaNCC, ncc.TenNCC, ncc.DiaCHi, ncc.DienThoai, ncc.email, pn.SoPN, pn.NgayNhap 
	from phieunhap pn join nhacungcap ncc on pn.MaNCC = ncc.MaNCC
	where pn.Ngaynhap between '2023-11-01 00:00:00' and '2023-12-01 00:00:00'
    order by pn.Ngaynhap;
-- 6
select ctpx.SoPX, nv.HoTen, px.Ngayban, ctpx.MaSP, sp.TenSP, sp.DonviTinh, ctpx.SoLuong, ctpx.GiaBan, ctpx.SoLuong * ctpx.GiaBan as DoanhThu
	from (((phieuxuat px
		join nhanvien nv on px.MaNV = nv.MaNV)
        join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
        join sanpham sp on sp.MaSP = ctpx.MaSP)
	where px.Ngayban between '2023-06-01 00:00:00' and '2024-01-01 00:00:00';
-- 7
select * from khachhang where month(ngaysinh) = month(now()); 
-- 8
select ctpx.SoPX, nv.HoTen as NhanVienBanHang, px.Ngayban, ctpx.MaSP, sp.TenSP, sp.DonviTinh, ctpx.SoLuong, ctpx.GiaBan, ctpx.SoLuong * ctpx.GiaBan as DoanhThu
	from (((phieuxuat px
		join nhanvien nv on px.MaNV = nv.MaNV)
        join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
        join sanpham sp on sp.MaSP = ctpx.MaSP)
	where px.Ngayban between '2023-08-15 00:00:00' and '2023-09-015 00:00:00';
-- 9
select px.SoPX, px.NgayBan, kh.MaKH, kh.TenKH, sum(ctpx.GiaBan * ctpx.SoLuong) as TriGia
	from ((phieuxuat px 
		join khachhang kh on px.MaKH = kh.MaKH) 
        join ctphieuxuat ctpx on px.SoPX = ctpx.SoPX)
	group by px.SoPX;
-- 10
select sp.TenSP,sum(ctpx.soluong) as SoLuongBan, sp.DonviTinh
	from ((ctphieuxuat ctpx 
		join sanpham sp on ctpx.MaSp = sp.MaSP)
		join phieuxuat px on px.SoPX = ctpx.SoPX)
	where px.NgayBan between '2023-06-01 00:00:00' and '2024-01-01 00:00:00' and sp.TenSP = 'iPhone 12'
    group by sp.MaSP;

-- 11
select month(px.NgayBan) as Thang, kh.MaKH, kh.TenKH, kh.DiaChi, sum(ctpx.GiaBan * ctpx.SoLuong) as TongTien
	from ((phieuxuat px 
		join khachhang kh on px.MaKH = kh.MaKH) 
        join ctphieuxuat ctpx on px.SoPX = ctpx.SoPX)
	group by px.SoPX
    order by px.ngayban;
-- 12
select year(px.NgayBan) as Nam, month(px.NgayBan) as Thang,sp.TenSP, sp.DonviTinh,sum(ctpx.soluong) as SoLuongBan
	from ((ctphieuxuat ctpx 
		join sanpham sp on ctpx.MaSP = sp.MaSP)
		join phieuxuat px on px.SoPX = ctpx.SoPX)
    group by year(px.NgayBan), month(px.NgayBan), sp.MaSP
    order by month(px.NgayBan);

-- 13
select month(px.NgayBan) as Thang, sum(ctpx.SoLuong * ctpx.GiaBan) as DoanhThu from phieuxuat px join ctphieuxuat ctpx on px.SoPX = ctpx.SoPX group by month(px.NgayBan); 
-- 14
select px.SoPX, px.NgayBan, nv.HoTen as NhanVienBan, kh.TenKH as KhachHang, sum(ctpx.SoLuong * ctpx.GiaBan) as TongGiaTri
	from (((phieuxuat px 
		join nhanvien nv on  nv.MaNV = px.MaNV)
        join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
        join khachhang kh on kh.MaKH = px.MaKH) 
    where month(px.NgayBan) = 7 or month(px.NgayBan) = 8
    group by px.SoPX;
-- 15
select px.SoPX, kh.MaKH, kh.TenKH, nv.HoTen, px.NgayBan, sum(ctpx.GiaBan * ctpx.SoLuong) as TriGia
	from (((phieuxuat px 
		join nhanvien nv on nv.MaNV = px.MaNV)
        join khachhang kh on kh.MaKH = px.MaKH)
        join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
	where date(px.NgayBan) = date(now())
    group by px.SoPX;
-- 16
select nv.MaNV, nv.HoTen, sp.MaSP, sp.TenSP, sp.DonViTinh,sum(ctpx.SoLuong) as TongSoLuong 
	from (((phieuxuat px 
		join nhanvien nv on nv.MaNV = px.MaNV)
        join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
        join sanpham sp on sp.MaSP = ctpx.MaSP)
	group by sp.MaSP, nv.MaNV;
-- 17 Liệt kê các hóa đơn bán hàng cho khách vãng lai (KH01) trong quý 3/2023,
-- thông tin gồm số phiếu xuất, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng, đơn giá, thành tiền. 
select px.SoPX, px.NgayBan, sp.MaSP, sp.TenSP, sp.DonviTinh, ctpx.SoLuong, ctpx.GiaBan, ctpx.SoLuong * ctpx.GiaBan as ThanhTien
	from (((phieuxuat px 
		join khachhang kh on kh.MaKH = px.MaKH)
        join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
        join sanpham sp on sp.MaSP = ctpx.MaSP)
	where px.Ngayban between '2023-06-01 00:00:00' and '2023-09-01 00:00:00' and kh.MaKH = 'KH01';
-- 18
select sp.MaSp, sp.TenSP, lsp.Tenloaisp, sp.DonviTinh
	from sanpham sp join loaisp lsp on lsp.MaloaiSP = sp.Maloaisp
    where not exists(
select 1
	from ctphieuxuat ctpx join phieuxuat px on px.SoPX = ctpx.SoPX
    where sp.MaSP = ctpx.MaSP and px.NgayBan between '2023-01-01 00:00:00' and '2023-09-01 00:00:00');
-- 19
select ncc.MaNCC, ncc.TenNCC, ncc.DiaChi, ncc.DienThoai
	from nhacungcap ncc 
    where not exists ( 
    select 1
    from phieunhap pn 
    where ncc.MaNCC = pn.MaNCC and pn.NgayNhap between '2023-06-01 00:00:00' and '2023-09-01 00:00:00');
-- 20 
select kh.MaKH, kh.TenKH, kh.DiaChi, kh.NgaySinh, kh.SoDT, sum(ctpx.SoLuong * ctpx.GiaBan) as TongGiaTri
	from ((khachhang kh 
		join phieuxuat px on kh.MaKH = px.MaKH)
        join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
	where px.NgayBan between '2023-06-01 00:00:00' and '2023-09-01 00:00:00'
	group by kh.MaKH
    having TongGiaTri = (
		select max(TongGiaTri)
			from (
				select kh.MaKH, kh.TenKH, kh.DiaChi, kh.NgaySinh, kh.SoDT, sum(ctpx.SoLuong * ctpx.GiaBan) as TongGiaTri
					from ((khachhang kh 
						join phieuxuat px on kh.MaKH = px.MaKH)
						join ctphieuxuat ctpx on ctpx.SoPX = px.SoPX)
					where px.NgayBan between '2023-06-01 00:00:00' and '2023-09-01 00:00:00'
					group by kh.MaKH
            ) as TongGiaTriKhachHang
    );
-- 21
select kh.MaKH, kh.TenKH as KhachHang, count(px.SoPX) as TongSoDonHang
	from khachhang kh left join phieuxuat px on kh.MaKH = px.MaKH
    group by kh.MaKH;
-- 22
select nv.MaNV, nv.HoTen, kh.TenKH
	from nhanvien nv left join (phieuxuat px join khachhang kh on px.MaKH = kh.MaKH) on nv.MaNV = px.MaNV 
    group by nv.MaNV, kh.MaKH;
-- 23 
select distinct count(nv.GioiTinh = 1) as SoLuongNam,  count(nv.GioiTinh = 0) as SoLuongNu
	from nhanvien nv
    group by nv.GioiTinh;
-- 24
select nv.MaNV, nv.HoTen, year(now()) - year(nv.NgayVaoLam) as NamLamViec
	from nhanvien nv
    where year(now()) - year(nv.NgayVaoLam) = (
		select max(NamLamViec)
			from ( 
				select year(now()) - year(nv.NgayVaoLam) as NamLamViec
					from nhanvien nv
                ) as NamLamViecLonNhat
    );
-- 25
select *
	from nhanvien nv
    where (year(now()) - year(nv.NgaySinh) = 60 and nv.GioiTinh = 1 ) or (year(now()) - year(nv.NgaySinh) = 55 and nv.GioiTinh = 0);
-- 26
select HoTen,
	case
		when GioiTinh = 1 then year(NgaySinh) + 60 
        when GioiTinh = 0 then year(NgaySinh) + 55
        else null
	end as NamVeHuu 
from nhanvien;
-- 27
select MaNV, HoTen, year(now()) - year(NgayVaoLam) as ThamNien,  
	case
		when year(now()) - year(NgayVaoLam) < 1 then  200000
        when year(now()) - year(NgayVaoLam) >=1 and year(now()) - year(NgayVaoLam) < 3 then  400000
        when year(now()) - year(NgayVaoLam) >=3 and year(now()) - year(NgayVaoLam) < 5 then  600000
        when year(now()) - year(NgayVaoLam) >=5 and year(now()) - year(NgayVaoLam) < 10 then  800000
        when year(now()) - year(NgayVaoLam) >= 10 then  1000000
        else null
	end as ThuongTet 
from nhanvien;
-- 28 
select sp.MaSP, sp.TenSP, lsp.TenloaiSP
from sanpham sp join loaisp lsp on sp.MaloaiSp = lsp.MaloaiSP
where lsp.TenloaiSP like 'Điện thoai di động';
-- 29
select sp.MaSP, sp.TenSP, lsp.TenloaiSP
from sanpham sp join loaisp lsp on sp.MaloaiSp = lsp.MaloaiSP
where lsp.TenloaiSP like 'Laptop';
-- 30
select t1.TenloaiSP, t1.SoLuong - t2.SoLuong as SoLuong
from 
( 
	select lsp.TenloaiSP as TenLoaiSP, sum(ctpn.SoLuong) as SoLuong 
	from sanpham sp  
		join loaisp lsp on lsp.MaloaiSP = sp.MaloaiSP 
		join ctphieunhap ctpn on ctpn.MaSP = sp.MaSP 
	where lsp.TenloaiSP like 'Điện thoaị di động' 
	group by lsp.MaLoaiSP 
) t1 
left join 
(
	select lsp.TenloaiSP as TenLoaiSP, sum(ctpx.SoLuong) as SoLuong 
	from sanpham sp  
		join loaisp lsp on lsp.MaloaiSP = sp.MaloaiSP 
		join ctphieuxuat ctpx on ctpx.MaSP = sp.MaSP 
	where lsp.TenloaiSP like 'Điện thoaị di động' 
	group by lsp.MaLoaiSP 
) t2 on t2.TenloaiSP = t1.TenloaiSP;
-- 31
select t1.TenloaiSP, t1.SoLuong - t2.SoLuong as SoLuong
from 
( 
	select lsp.TenloaiSP as TenLoaiSP, sum(ctpn.SoLuong) as SoLuong 
	from sanpham sp  
		join loaisp lsp on lsp.MaloaiSP = sp.MaloaiSP 
		join ctphieunhap ctpn on ctpn.MaSP = sp.MaSP 
	group by lsp.MaLoaiSP 
) t1 
left join 
(
	select lsp.TenloaiSP as TenLoaiSP, sum(ctpx.SoLuong) as SoLuong 
	from sanpham sp  
		join loaisp lsp on lsp.MaloaiSP = sp.MaloaiSP 
		join ctphieuxuat ctpx on ctpx.MaSP = sp.MaSP 
	group by lsp.MaLoaiSP 
) t2 on t2.TenloaiSP = t1.TenloaiSP;




