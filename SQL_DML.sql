-- 0 เพิ่มเงินเดือน 10% ให้อาจารย์ที่เคยสอนวิชา cs004 ในปี 2020

select * from LECTURER

update  lecturer
set     salary += salary*0.1
where   lid in 
            (select  lecid
            from    section
            where   subid = 'cs004'
            and     SUBSTRING(term,3,4) = '2020')

select * from LECTURER

-- 1 ให้นิสิตทุกคนที่เรียนวิชา cs004 ในเทอม 1-2019 ได้เกรด A

select * from ENROLL

update  ENROLL
set     grade = 'A'
where   stdid in 
            (select  stdid
            from    ENROLL, SECTION
            where   ENROLL.secid = SECTION.secid
            and     term = '1-2019')

select * from ENROLL

-- 2 เพิ่มเงินเดือน 10% ให้อาจารย์ทุกคนที่สอนในปี 2020

select  * from    LECTURER

UPDATE  LECTURER 
SET     salary += salary*0.1
where   lid in 
        (SELECT  lid 
        from    LECTURER, SECTION
        where   LECTURER.lid = SECTION.lecid
        and     SUBSTRING(term,3,4) = '2020')

select  * from    LECTURER


-- 3 เพิ่มเงินเดือน 20% ให้อาจารย์ทุกคนที่มีเงินเดือนต่ำกว่าค่าเฉลี่ยเงินเดือนของอาจารย์ทั้งหมด

SELECT * FROM LECTURER

UPDATE  LECTURER 
SET     salary += salary*0.2 
WHERE   salary < (SELECT AVG(salary) as avg_salary FROM LECTURER)

SELECT * FROM LECTURER

-- 4 เพิ่มเงินเดือน 10% ให้อาจารย์ที่สอนมากกว่า 1 วิชาใน 1-2020

SELECT * FROM LECTURER

UPDATE  LECTURER 
SET     salary += salary*0.1
where   lid in 
            (SELECT      lecid
            FROM        SECTION
            WHERE       term = '1-2020'
            group by    lecid
            having      COUNT(subid)>1)

SELECT * FROM LECTURER

-- 5.ลบอาจารย์ในปี 2020 ไม่ได้สอนเลย

SELECT  * FROM LECTURER

DELETE  LECTURER 
WHERE   lid not in 
            (SELECT lecid
            FROM    SECTION
            WHERE   SUBSTRING(term,3,4) = '2020') 

SELECT  * FROM LECTURER

-- 6.ลบวิชาที่ไม่เคยเปิดสอน

SELECT * FROM SUBJECT

DELETE  SUBJECT
WHERE   sid not in 
                (SELECT  subid 
                FROM    SECTION) 

SELECT * FROM SUBJECT







