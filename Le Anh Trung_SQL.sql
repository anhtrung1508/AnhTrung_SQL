--- TẠO BẢNG STUDENTS, COURSE, TEACHER , ENROLLMENTS
CREATE TABLE STUDENTS (
    sID CHAR(5),
    sFirstName VARCHAR(10),
    sLastName VARCHAR(10),
    sPhone CHAR(10),
    sAddress VARCHAR(50)
)

CREATE TABLE COURSE(
    cID CHAR(5),
    cMajor VARCHAR(10),
    cName VARCHAR(30)
)

CREATE TABLE TEACHERS (
    tID CHAR(5),
    tFirstName VARCHAR(10),
    tLastName VARCHAR(10),
    tPhone CHAR(10),
    tType BIT,
    tMajor VARCHAR(10)
)

CREATE TABLE ENROLLMENTS(
   sID CHAR(5) NOT NULL
  ,cID CHAR(5) NOT NULL
  ,tID CHAR(5)
);

-- ĐIỀN DỮ LIỆU VÀO 4 BẢNG
INSERT INTO STUDENTS VALUES
('M0001','Minh','Nguyen','0323456789','Quang Binh'),
('M0002','Hai','Do','0143456789','Ha Nôi'),
('M0003','Bao','Nguyen','0123656789','Quang Binh'),
('M0004','Thuan','Tran','0123456289','Sai Gon'),
('M0005','Thao','Doan','0223456589','Sai Gon'),
('M0006','Giau','Le','0723456459','Binh Phuoc'),
('M0007','Khoa','Tran','0343452780','Dong Nai')

INSERT INTO COURSE VALUES
('MC001','Data','D4E'),
('MC002','Data','BI'),
('MC003','Data','BE Basic'),
('MC004','Web','Web Basic'),
('MC005','Web','FullStack'),
('MC006','Finance','FM Basic'),
('MC007','Finance','FM Intensive')

INSERT INTO TEACHERS VALUES
('T0001','Bao','Nguyen','0233456789',1,'Finance'),
('T0002','Duy','Vo','0233456789',1,'Web'),
('T0003','Khoa','Dao','0113656789',0,'Web'),
('T0004','Phuoc','Nguyen','0347456289',0,'Finance'),
('T0005','Nghia','Cao','0562456590',0,'Data'),
('T0006','Ha','San','078456459',1,'Data')

INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0001','MC001','T0005');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0002','MC002','T0006');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0003','MC003','T0006');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0004','MC004','T0002');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0005','MC005',NULL);
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0003','MC001','T0005');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0006','MC002','T0006');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0002','MC003','T0006');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0002','MC004','T0002');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0006','MC005','T0003');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0004','MC001','T0005');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0001','MC002','T0006');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0006','MC003',NULL);
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0006','MC004','T0002');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0002','MC005','T0003');
INSERT INTO ENROLLMENTS(sID,cID,tID) VALUES ('M0002','MC006',NULL);

-- Giáo viên là mentor, super teacher
select * from TEACHERS
where tType = 0

SELECT * from TEACHERS
where tType = 1

-- các học sinh có địa chỉ ở Nghệ An
select * from STUDENTS
where sAddress = 'Nghe An'

-- Xoá môn Finance và giáo viên Finance
Delete from TEACHERS
WHERE tMajor = 'Finance'

DELETE from COURSE
where cMajor = 'Finance'

-- Đổi khoá học có tên từ BE Basic sang Web
UPDATE COURSE
SET cName = 'Web'
where cName = 'BE Basic'

-- Xoá tên gv Bao Nguyen
DELETE from TEACHERS
where tFirstName = 'Bao'and 
    tLastname = 'Nguyen'

-- Cập nhật gv Phuoc Nguyen sang Data
UPDATE TEACHERS
set tMajor = 'Data'
where tFirstName = 'Phuoc'
and tLastName = 'Nguyen'

-- Set up khoá chính, khoá ngoại cho các bảng
ALTER TABLE TEACHERS
ALTER COLUMN tID Char(5) Not NULL;
ALTER table TEACHERS ADD CONSTRAINT PK_tID PRIMARY KEY (tID);

Alter table STUDENTS
ALTER column sID char(5) not NULL;
ALTER table STUDENTS ADD CONSTRAINT PK_sID PRIMARY KEY (sID);

ALTER table COURSE 
ALTER COLUMN cID char(5) not NULL;
ALTER table COURSE ADD CONSTRAINT PK_cID PRIMARY KEY (cID);

ALTER TABLE ENROLLMENTS ADD CONSTRAINT FK_Teachers FOREIGN KEY (tID) REFERENCES TEACHERS (tID);
ALTER TABLE ENROLLMENTS ADD CONSTRAINT FK_Students FOREIGN KEY (sID) REFERENCES STUDENTS (sID);
ALTER TABLE ENROLLMENTS ADD CONSTRAINT FK_Course FOREIGN KEY (cID) REFERENCES COURSE (cID);

TRUNCATE TABLE COURSE

--- tìm ra giảng viên là Super Teacher của khoa Data
Select * 
from TEACHERS
WHERE tType = 1 
and tMajor = 'Data'

-- Học viên học môn MC003, dạy bởi giáo viên T00003
Select * 
from ENROLLMENTS
WHERE cID = 'MC003'
and tID = 'T0003'

-- Những học viên đăng ký môn học thuộc khoa Data
select distinct s.sID, s.sFirstName, s.sLastName, s.sPhone, s.sAddress, c.cMajor
from STUDENTS s
join ENROLLMENTS e 
on s.sID = e.sID
join COURSE c 
on c.cID = e.cID
where c.cMajor = 'Data'

-- tìm enrollments là null và thay thành giáo viên dạy
select * from ENROLLMENTS  where tID is NULL
SELECT * from COURSE where cID in ('MC005', 'MC003', 'MC006')
SELECT * from STUDENTS where sID in ('M0005', 'M0002', 'M0006')

UPDATE ENROLLMENTS set tID = 'T0002' where cID = 'MC005' and tID is NULL
UPDATE ENROLLMENTS set tID = 'T0006' where cID = 'MC003' and tID is NULL
UPDATE ENROLLMENTS set tID = 'T0001' where cID = 'MC006' and tID is NULL;

-- TẠO BẢNG LEARNING
CREATE TABLE LEARNING(
   sID   CHAR(5) NOT NULL
  ,cID   CHAR(5) NOT NULL
  ,score float NOT NULL
);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0001','MC001',4.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0002','MC002',3.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0003','MC003',6.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0004','MC004',2.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0005','MC005',5.0);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0003','MC001',8.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0006','MC002',6.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0002','MC003',9.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0002','MC004',7.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0006','MC005',5.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0004','MC001',8.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0001','MC002',4.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0006','MC003',9.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0006','MC004',4.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0002','MC005',4.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0002','MC006',2.2);

-- MÃ + TÊN HỌC VIÊN, HỌC WEB BASIC VÀ CÓ GIÁO VIÊN TÊN LÀ DUY
select 
   s.sFirstName, s.sLastName,c.cName,t.tFirstName
from STUDENTS s
join  ENROLLMENTS e on  s.sID = e.sID
JOIN  TEACHERS t on t.tID = e.tID
JOIN COURSE c on e.cID = c.cID
WHERE c.cName = 'Web Basic' and t.tFirstName = 'Duy'

-- Tìm những học viên không đăng ký môn học
select s.*, c.* from STUDENTS s
left join ENROLLMENTS e on s.sID = e.sID
left join COURSE c on c.cID = e.cID
where c.cID is NULL

-- Môn học không có học viên đăng ký 
select c.*, s.* from COURSE c
LEFT join ENROLLMENTS e on e.cID = c.cID
left join STUDENTS s on s.sID = e.sID
where s.sID is NULL

-- Những học viên < 4 là trượt
with dtb AS
(Select s.sID, s.sFirstName, s.sLastName,s.sPhone, l.score
from STUDENTS s
join LEARNING l on s.sID = l.sID)
select *,
CASE 
WHEN score < 4 then 'Fail'
else 'Pass'
end as ketqua
from dtb

-- môn học có học viên đạt điểm thấp nhất là môn nào? giáo viên nào?
select top 1 s.sID,s.sFirstName,s.sLastName,t.tID,t.tFirstName,t.tLastName,c.cID,c.cMajor,c.cName,l.score from STUDENTS s 
join LEARNING l 
on l.sID = s.sID
join ENROLLMENTS e 
on e.sID = s.sID
join COURSE c 
on c.cID = e.cID
join TEACHERS t
on t.tID = e.tID
order by l.score asc

-- tìm học viên do gvien này dạy
select l.* 
from LEARNING l 
join ENROLLMENTS e on l.cID = e.cID and l.sID = e.sID
where e.cID = 'MC004' and e.tID = 'T0002'

--- thêm dữ liệu Students và Learnings
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0008','Minh','Nguyen','0912345678','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0009','Linh','Tran','0987654321','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0010','Hoang','Le','0901234567','Da Nang');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0011','Thao','Pham','0976543210','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0012','Binh','Hoang','0923456789','Hai Phong');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0013','Huong','Nguyen','0967890123','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0014','Nam','Tran','0945678901','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0015','Quang','Ly','0934567890','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0016','Lan','Dang','0956789012','Da Nang');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0017','Tu','Vo','0989012345','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0018','Hai','Nguyen','0910123456','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0019','Anh','Tran','0943210765','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0020','Duc','Le','0965432109','Da Nang');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0021','Hanh','Hoang','0921098765','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0022','Hung','Phan','0978901234','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0023','Hong','Nguyen','0932109876','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0024','Tien','Tran','0909876543','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0025','My','Ly','0912345670','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0026','Tam','Do','0987654320','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0027','Thanh','Vuong','0943210789','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0028','Trang','Le','0965432108','Da Nang');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0029','Quynh','Tran','0921098764','Da Nang');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0030','Duc','Pham','0978901236','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0031','Thuy','Le','0932109875','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0032','Hung','Nguyen','0909876541','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0033','Thuy','Hoang','0912345672','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0034','Tan','Tran','0987654323','Ho Chi Minh City');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0035','Thanh','Ly','0943210786','Hanoi');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0036','Ngoc','Dang','0965432105','Da Nang');
INSERT INTO Students(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0037','Duong','Vo','0921098769','Ho Chi Minh City');

INSERT INTO LEARNING(sID,cID,score) VALUES ('M0010','MC003',7.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0010','MC005',5.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0017','MC001',7.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC002',3.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0028','MC002',5.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC001',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0035','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC001',4.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC006',2.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC005',6.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC006',0.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC001',1.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC006',0.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0011','MC005',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0033','MC007',2.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0019','MC005',9.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC005',2.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0028','MC007',4.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC001',8.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC003',9.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC007',1.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC004',6.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0035','MC007',6.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC007',7.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC001',0.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC007',1.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0021','MC003',7.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC002',3.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC001',4.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC002',7.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC002',9.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0018','MC005',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC001',1.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0011','MC007',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC003',4.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC005',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0037','MC002',9.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0009','MC003',0.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0016','MC003',9.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0031','MC003',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0027','MC007',5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC004',8.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0036','MC006',0.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC007',0);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC003',8.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0010','MC004',8.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0028','MC007',2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0016','MC006',0.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC004',3.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC005',1.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC001',2.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC003',8.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0023','MC001',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC001',6.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC003',6.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0011','MC001',6.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC003',3.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC005',7.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0033','MC002',2.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC002',6.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC005',2.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC004',3.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC007',6.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC001',5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC001',4.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC004',3.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0037','MC007',3.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC001',3.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0016','MC001',4.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC002',9.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC003',3.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC003',1.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0036','MC007',1.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0023','MC002',0.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0019','MC005',2.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC004',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0015','MC001',3.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0027','MC003',1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC005',9.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC002',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0017','MC003',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0030','MC004',1.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC005',8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0031','MC003',7.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0017','MC001',7.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC004',2.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0037','MC007',4.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0021','MC002',1.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0019','MC001',2.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0009','MC007',4.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC007',4.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0018','MC005',5.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC005',0.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC005',5.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0023','MC004',6.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC001',1.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0009','MC001',7);

--Điểm trung bình của các học viên theo từng khoa
SELECT c.cMajor, AVG(l.score) dtb
from LEARNING l 
join COURSE c 
on c.cID = l.cID
group by c.cMajor

-- Điểm theo từng môn học
SELECT c.cID,c.cName ,AVG(l.score) dtb
from LEARNING l 
join COURSE c 
on c.cID = l.cID
group by c.cID, c.cName

-- Hãy đếm số lượng học viên đạt kết quả giỏi, khá và trung bình.
with overall as 
(select s.sID, avg(l.score) dtb
from STUDENTS s
join LEARNING l
on l.sID = s.sID
group by s.sID)
, cte2 AS
(select * 
,case 
when dtb > 8 then N'Học sinh giỏi'
when dtb < 8 and dtb > 5 then N'Học sinh TB'
else N'Học sinh yếu'
end as thanhtich
from overall)
select thanhtich, count(thanhtich) as qty
from cte2
group by thanhtich

-- điểm lớn nhất, điểm bé nhất, khoảng cách giữa điểm lớn nhất và điểm bé nhất của từng môn học là bao nhiêu?
with cte1 as 
(SELECT c.cName, max(l.score) max
from LEARNING l 
join COURSE c 
on c.cID = l.cID
group by c.cName)
, cte2 as 
(SELECT c.cName, min(l.score) min
from LEARNING l 
join COURSE c 
on c.cID = l.cID
group by c.cName)

select a.cName, a.max, b.min, round(a.max - b.min,1) as chenhlech
from cte1 a
join cte2 b
on a.cName = b.cName

-- Số lượng khách hàng của từng nhóm khách hàng trong CUSTOMER_GROUP 
Select rank, count(rank) as quantity
from sales.Customer_Group
group by rank

-- Số lượng đơn hàng của từng nhóm wait_type là bao nhiêu
select wait_type, count(wait_type) as quantity
from sales.WAIT_TIME
group by wait_type

-- tổng số item được mua của từng đơn hàng.
SELECT SalesOrderID, sum(OrderQty) as quantity
from [Sales].[SalesOrderDetail]
group by SalesOrderID
order by quantity desc

-- tìm ra tổng doanh số của từng ProductSubCategory
Select ps.Name ,sum(s.LineTotal) rev
from [Production].[ProductSubcategory] ps 
join [Production].[Product] p on p.ProductSubcategoryID = ps.ProductSubcategoryID
join [Sales].[SalesOrderDetail] s on s.ProductID = p.ProductID
group by ps.Name

-- tổng doanh số của các Category có các sản phẩm được thay đổi giá bán.
select pc.Name, sum(s.LineTotal) rev
from sales.SalesOrderDetail s
join Production.Product p on p.ProductID = s.ProductID
join Production.ProductSubcategory ps on ps.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc on pc.ProductCategoryID = ps.ProductCategoryID
where p.ProductID IN (select distinct ProductID from Production.ProductCostHistory)
group by pc.Name

--- BÀI TẬP 5
-- 1. TÌM RA NHỮNG KHÁCH HÀNG NHẬN HÀNG LÂU NHẤT
Select * 
from sales.WAIT_TIME
where time_wait = (select max(time_wait) from sales.WAIT_TIME)

-- 2. có bao nhiêu đơn hàng có giá trị cao hơn giá trị trung bình
select *
from sales.Customer_Group
where order_qtty > (select avg(order_qtty) from sales.Customer_Group)

-- 2+ 3. thực hiện bằng cte 
Select pc.Name, sum(s.LineTotal) rev
from sales.SalesOrderDetail s
join Production.Product p on s.ProductID = p.ProductID
join Production.ProductSubCategory psc on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc on psc.ProductCategoryID = pc.ProductCategoryID 
group by pc.Name

-- 4. Subcategory mang lại doanh thu nhiều nhất cho từng category
with cte1 AS
(Select pc.Name as category, psc.Name as subcategory ,sum(s.LineTotal) rev
from sales.SalesOrderDetail s
join Production.Product p on s.ProductID = p.ProductID
join Production.ProductSubCategory psc on psc.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory pc on psc.ProductCategoryID = pc.ProductCategoryID 
group by pc.Name, psc.Name)
,cte2 as 
(select category, max(rev) max
from cte1
group by category)
select cte1.*
from cte2
join cte1 on cte2.category = cte1.category and cte2.max = cte1.rev

-- 5. View DS học viên đăng ký thuộc khoa data
Create view hsdata as
select S.*, c.cMajor,c.cName
from STUDENTS s 
join ENROLLMENTS e on e.sID = s.sID
join COURSE c on c.cID = e.cID
where c.cMajor = 'Data'

-- web
Create view hsweb as
select S.*, c.cMajor,c.cName
from STUDENTS s 
join ENROLLMENTS e on e.sID = s.sID
join COURSE c on c.cID = e.cID
where c.cMajor = 'Web'

-- giảng viên dạy nhiều hơn 2 môn học
CREATE VIEW teachermorethan2 as
select t.*, count(e.cID) as qty
from TEACHERS t 
join ENROLLMENTS e on e.tID = t.tID
group by t.tFirstName, t.tLastName, t.tMajor, t.tPhone,t.tType, t.tID
having COUNT(e.cID) > 2

-- Tìm ra những sinh viên có điểm tổng kết môn học cao nhất, thấp nhất của 2 khoa kể trên
with cte1 as
(select s.*,c.cMajor, l.score
from STUDENTS s 
join LEARNING l on l.sID = s.sID
join COURSE c on l.cID = c.cID
group by s.sID,s.sAddress,s.sFirstName,s.sLastName,s.sPhone, c.cMajor,l.score)
, cte2 AS
(SELECT cMajor,max(score) Max, min(score) as Min
from cte1
group by cMajor)
SELECT cte1.sFirstName,cte1.sLastName, cte1.cMajor ,score
from cte2
join cte1 on cte1.cMajor = cte2.cMajor
where cte1.score = cte2.[Max]
UNION ALl
SELECT cte1.sFirstName,cte1.sLastName,cte1.cMajor ,score
from cte2
join cte1 on cte1.cMajor = cte2.cMajor
where cte1.score = cte2.[Min]
