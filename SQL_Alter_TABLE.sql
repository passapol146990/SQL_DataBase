-- การเปลี่ยนชื่อ table 
sp_rename 'student', 'st'

-- การเปลี่ยนชื่อ column
sp_rename 'student.name', 'fname' 

-- เพิ่ม column
alter table studen
add phone VARCHAR(10), address VARCHAR(300)

-- ลบ column
alter table student
drop column name, marjor

-- แก้ไข column
alter table student
alter column name varchar(200)

-- ลบ constraint ออกจาก column
alter table student
drop constraint std_gpa

-- เพิ่ม constraint เข้า column
alter table student
add constraint std_gpa

-- 
-- 1 แก้ไข table STUDENT ให้สามารถเก็ย ที่อยู่ เบอร์โทรได้

ALTER TABLE STUDENT
add address VARCHAR(300), phone VARCHAR(10) 

-- 2 แก้ไข table STUDENT ให้มีข้อมูล รหัสอาจารย์ที่ปรึกษา โดย รหัสอาจารย์ที่ปรึกษา reference จาก table LECTURER

SELECT * FROM LECTURER
SELECT * FROM STUDENT

alter table STUDENT
add lecid varchar(10) 

alter table STUDENT
add constraint st_lecid FOREIGN KEY (lecid) REFERENCES LECTURER(lid)

-- 3 แก้ไข table ENROLL โดยเพิ่มคอลัมน์เพื่อเก็บข้อมูลวันที่บันทึกเกรด

alter table ENROLL
add EditDate date

-- 4 เปลี่ยนชื่อ column marjot ของ table LECTURER เป็น departmenp

SELECT * FROM LECTURER

sp_rename 'LECTURER.major', 'departmenp'

SELECT * FROM LECTURER

-- 5 ลบ column birthday ของ table STUDENT

SELECT * FROM STUDENT

alter table STUDENT
drop column birthday

-- 6 กำหนด salary ของ table LECTURER มีค่าอยู่ระหว่าง 10000-50000

sp_help LECTURER

select * from LECTURER

alter table LECTURER
add CONSTRAINT lec_salary CHECK (salary BETWEEN 10000 and 500000)

-- 7 ลบ column อาจารย์ที่ปรึกษาออกจาก table STUDENT(ถ้าลบไม่ได้ให้อ่าน error แล้วแก้ให้ได้)

select * from STUDENT

sp_help STUDENT

alter table STUDENT
drop CONSTRAINT st_lecid

alter table STUDENT
drop column lecid






