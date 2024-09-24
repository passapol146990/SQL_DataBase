-- Stored Procedure ฟังก์ชันเรียกใข้ได้เลยสะดวกสบายมาก
CREATE PROCEDURE display_1
AS 
    SELECT  sid, name, major, gpa
    FROM    student
    WHERE   gpa > 3.00
EXEC display_1

CREATE PROCEDURE display_2
    @gpa    float
AS 
    SELECT  sid, name, major, gpa
    FROM    student
    WHERE   gpa > @gpa
EXEC display_2 3.00
EXEC display_2 1.5

CREATE PROCEDURE display_3
    @gpa    FLOAT
    @major  VARCHAR(100)
AS
    SELECT  sid, name, major, gpa
    FROM    student
    WHERE   gpa > @gpa
    AND     major = @major

EXEC display_3 2.5 'cs'

-- default
CREATE PROCEDURE display_4
    @major  VARCHAR(100)
    @gpa    FLOAT = 3.00
AS
    SELECT  sid, name, major, gpa
    FROM    student
    WHERE   gpa > @gpa
    AND     major = @major

-- สร้างแบบ delete update ได้หมดเลยเหมือนชุดคำสั่งที่เตรียมไว้แค่นำไปเรียกใช้ง่ายๆ
-- การประกาศตัวแปร
CREATE PROCEDURE display_5
    @major  VARCHAR(50)
AS
    DECLARE
        @MAX_GPA    FLOAT,
        @MIN_GPA    FLOAT
    SELECT @MAX_GPA = MAX(gpa) FROM STUDENT WHERE major = @major
    SELECT @MAX_GPA = MIN(gpa) FROM STUDENT WHERE major = @major

    SELECT  *
    FROM    STUDENT
    WHERE   gpa     = @MAX_GPA
    AND     major   = @major
        UNION
    SELECT  *
    FROM    STUDENT
    WHERE   gpa     = @MIN_GPA
    AND     major   = @major

-- if else
CREATE PROCEDURE demo_inc_salary
AS 
    DECLARE @avg_salary VARCHAR(50)
    SELECT  @avg_salary = AVG(salary) FROM LECTURER

    PRINT 'AVG salary = '+@avg_salary

    if(@avh_salary >= 40000)
    BEGIN
        PRINT 'update 5%'
        UPDATE LECTURER
        SET     salary += salary*0.05
    END
    ELSE
    BEGIN
        PRINT   'update 10%'
        UPDATE  LECTURER
        SET     salary += salary*0.10
    END

-- แบบฝึกหัด 1-8

-- สร้าง Stored Procedure ให้เหมาะสมกับการทำงานต่างๆ ดังนี้ ( xx, yy คือตัวแปร )
-- 1.[msp_young_students ]     แสดง sid, name, major, age ของนิสิตทุกคนที่อายุอยู่ในช่วง xx ถึง yy ปี
CREATE PROCEDURE [msp_young_students]
    @min_age    INT,
    @max_age    INT
AS
    SELECT  sid ,name major, datediff(year,birthday,GETDATE()) as age
    FROM    STUDENT
    WHERE   datediff(year,birthday,GETDATE()) BETWEEN @min_age and @max_age
---------------------------------------------------------------
DROP PROCEDURE [msp_young_students]
EXEC    [msp_young_students] 19, 20

-- 2.[msp_any_sub_students ]  แสดง sid, name, term, grade ของนิสิตที่เคยเรียนวิชาชื่อ xx
CREATE PROCEDURE [msp_any_sub_students]
    @subject_name  VARCHAR(255)
AS 
    SELECT  STUDENT.sid, STUDENT.name, SECTION.term, ENROLL.grade
    FROM    STUDENT, ENROLL, SECTION, SUBJECT
    WHERE   STUDENT.sid     = ENROLL.stdid 
    AND     ENROLL.secid    = SECTION.secid
    AND     SECTION.subid   = SUBJECT.sid
    AND     SUBJECT.name    = @subject_name
--------------------------------------------------------
EXEC    [msp_any_sub_students] 'OOP'
-- 3.[msp_major_grade_students ]  แสดงจำนวนนิสิตในภาควิชา xx ที่ได้ gpa สูงกว่า yy
CREATE PROCEDURE [msp_any_grade_students]
    @major    VARCHAR(100),
    @gpa       INT
AS
    SELECT  count(*) 
    FROM    STUDENT
    WHERE   major = @major
    AND     gpa   > @gpa
---------------------------------------------------------
EXEC  [msp_any_grade_students] 'CS', 2.5

-- 4.[msp_delete_subject]  	เพื่อลบข้อมูลวิชาที่ไม่เคยเปิดสอนเลย
CREATE PROCEDURE [msp_delete_subject]
AS 
    DELETE SUBJECT 
    WHERE sid NOT IN 
                    ((SELECT  subid FROM SECTION))
--------------------------------------------------------
DROP PROCEDURE [msp_delete_subject]
EXEC [msp_delete_subject]

-- 5.[msp_enroll_report] 	เพื่อแสดงรายละเอียดการลงทะเบียนเรียนในเทอม xx 
-- โดยแสดง secid, subid  และ จำนวนนิสิตที่ลงเรียนใน secid  นั้น
CREATE PROCEDURE [msp_enroll_report]
    @trem   VARCHAR(50)
As
    SELECT  SECTION.secid, COUNT(ENROLL.secid)
    FROM    ENROLL,SECTION
    WHERE   ENROLL.secid  = SECTION.secid
    AND     term  = @trem
    GROUP BY SECTION.secid, ENROLL.secid
--------------------------------------------------------
EXEC    [msp_enroll_report] '1-2020'
EXEC    [msp_enroll_report] '#'SELECT * FROM information_schema.columns--'
EXEC    [msp_enroll_report] '#'SELECT * FROM type--'


-- 6.[msp_increase_salary_a] 	เพื่อเพิ่มเงินเดือนให้อาจารย์ภาควิชา xx โดยเพิ่ม yy %
CREATE PROCEDURE [msp_increase_salary_a]
    @major     VARCHAR(50),
    @persen    FLOAT
AS
    UPDATE LECTURER
    SET     salary += salary*(@persen/100.0)
    WHERE   lid in (SELECT  lid 
                    FROM    LECTURER
                    WHERE   major = @major)
--------------------------------------------------------
DROP PROCEDURE [msp_increase_salary_a]
EXEC  [msp_increase_salary_a] 'CS', 10.2

-- 7.[msp_increse_salary_b]	เพื่อเพิ่มเงินเดือนให้อาจารย์ โดยเพิ่มตามจำนวนวิชาที่สอนในปีนั้น ๆ
-- มีการรับ  parameter 2 ตัว คือ
-- year	    คือ ปีที่ต้องการให้เพิ่มเงินเดือน
-- money	คือ จำนวนเงินที่เพิ่มขึ้นตามวิชาที่สอนในปีนั้น ๆ   เช่น
-- msp_increase_salary_b 2021  3000 หมายถึง เพิ่มเงินเดือนให้อาจารย์ที่สอนปี 2021 วิชาละ 3000 บาท
-- msp_increase_salary_b 2022  1000 หมายถึง เพิ่มเงินเดือนให้อาจารย์ที่สอนปี 2022 วิชาละ 1000 บาท
-- *หมายเหตุ*  ควรสร้าง View เพื่อเช็คว่าแต่ละปีอาจาย์สอนกี่วิชา เช่น TeachByYear (lecid, year, amount)
CREATE VIEW TeachByYear as 
SELECT  lecid, SUBSTRING(term,3,4) as year, count(lecid) as amount
FROM    SECTION
GROUP BY lecid, term

SELECT * FROM TeachByYear

CREATE PROCEDURE [msp_increse_salary_b] 
    @year    VARCHAR(10),
    @money   FLOAT
AS 
    UPDATE  LECTURER
    SET     salary += @money * TeachByYear.amount
    FROM    LECTURER, TeachByYear
    WHERE   LECTURER.lid in (SELECT  lecid 
                            FROM    TeachByYear 
                            WHERE   year = @year)
----------------------------------------------------------------
DROP PROCEDURE [msp_increse_salary_b] 
SELECT * FROM LECTURER
EXEC    [msp_increse_salary_b] '2020', 100000
SELECT * FROM LECTURER
FROM    LECTURER, TeachByYear
WHERE   LECTURER.lid in (SELECT  lecid 
                        FROM    TeachByYear 
                        WHERE   year = @year)
-- 8.[msp_increase_salary_c] 	เพิ่มเงินเดือนอาจารย์ โดยมีการรับ parameter 3  ตัวคือ
-- mid_sal	คือค่าเงินเดือนที่เป็นตัวแบ่งการคำนวณ
-- i1 		คือเปอร์เซ็นต์การขึ้นเงินเดือนถ้าอาจารย์เงินเดือน <  mid_sal
-- i2		คือเปอร์เซ็นต์การขึ้นเงินเดือนถ้าอาจารย์เงินเดือน >=  mid_sal
-- * นั่นคือ อาจารย์แต่ละคนจะได้เงินเดือนขึ้นเปอร์เซ็นต์ไม่เท่ากัน ขึ้นอยู่กับเงินเดือนเดิมของอาจารย์
CREATE PROCEDURE [msp_increase_salary_c]
    @mid_sal    INT,
    @i1         FLOAT,
    @i2         FLOAT
AS
    UPDATE LECTURER
    SET     salary += (case
                        when salary >= @mid_sal then @i2
                        when salary <= @mid_sal then @i1
                        end)/100*salary
----------------------------------------------------------------  




SELECT USER_ID()
SELECT USER_NAME()
sp_help SECTION