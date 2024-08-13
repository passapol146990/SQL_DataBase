-- INTERSECT ข้อมูลที่ 2 ตารางมีเหมือนกัน
select lid, name
from lecturer, section
where lecturer.lid = section.lecid
and term = '1-2020'
INTERSECT
select lid, name
from lecturer, section
where lecturer.lid = section.lecid
and term = '3-2020'
-- EXCEPT เอาข้อมูลที่มีในตาราง 1 โดยที่ตาราง 2 ต้องไม่มีค่าเหมือนตาราง 1
select lid, name
from lecturer, section
where lecturer.lid = section.lecid
and term = '1-2020'
EXCEPT
select lid, name
from lecturer, section
where lecturer.lid = section.lecid
and term = '3-2020'
-- UNION เอาข้อมูลที่ไม่ซ้ำกันตาม SELENT ถ้าข้อมูลที่ต้องการ SELECT มันต้องกันจะเอามาอันเดียว ถ้ามีตรง collume ไหนสักอันเอามาหมด
select lid, name
from lecturer, section
where lecturer.lid = section.lecid
and term = '1-2020'
UNION
select lid, name
from lecturer, section
where lecturer.lid = section.lecid
and term = '3-2020'

-- Left outer join เอาฝั่งซ้ายมาทั้งหมดเลย
-- เอาข้อมูลจาก lecturer มาทั้งหมดรวมทั้งค่า null ด้วย
select distinct name, term
from lecturer left outer join section
on lecturer.lid = section.lecid

-- isnull(collume,"ข้อมูลที่ต้องการแทนค่า")
-- SELECT ISNULL(name,"ไม่มีชื่อ")  FROM ...


-- distinct เอาไว้ใช้นำหน้า SELECT ไม่ให้ซ้ำกัน

-- Nested คือเอา join ใน WHERE ซ้อนลงไปเรื่อยๆ
-- SELECT * FROM A 
-- WHERE id IN (
--     SELECT id FROM B WHERE B.id IN(
--         SELECT id FROM C
--     )
-- )
-- หรือ แสดงชื่ออาจารย์ที่ไม่ไดสอน ้ เทอม 1-2020 ก็คือเอาไอดีอาจารย์ที่สอนใน 1-2020 มาก่อนแล้วใช้ NOT IN ตรวจสอบ
select  distinct name
from    LECTURER
where   lid NOT IN
    (select lecid
    from    section
    where   term = '1-2020' )

-- แสดง sid และ ชื่อนิสิตที่เคยลงทะเบียนเรียน และไม่เคยติด F เลย
select  sid, name
from    student, enroll
where   student.sid = enroll.stdid
and sid NOT IN
        (select stdid
        from enroll
        where grade = 'F')

-- • แสดงรหัส ชื่อและ gpa ของนิสิตที่ได้gpa สูงที่สุด
select  *
from    student
WHERE   gpa = 
            (select max(gpa)
            from student)

-- แสดงรหัส ชื่อและ gpa ของนิสิตที่ได้gpa มากกว่าค่าเฉลี่ยน gpa ทั้งหมด
select  *
from    student
WHERE   gpa >
            (select avg(gpa)
            from student)
ORDER BY gpa desc

-- EXISTS มีอยู่ใน
-- แสดง name ของอาจารย์ที่เคยสอนวิชา Programming
select name
from lecturer
where EXISTS
        (select *
        from section, subject
        where lecturer.lid = section.lecid
        and section.subid = subject.sid
        and subject.name = 'Programming' )

-- แสดงรหัส และชื่ออาจารย์ของอาจารยที่สอนมากกวา่ 2 วิชา
select lid, name
from lecturer
where EXISTS
        (select lecid, count(*)
        from section
        where lecturer.lid = section.lecid
        group by lecid
        having count(*) > 2 )
-- หรือ ทำงานเหมือนกัน
select lid, name
from lecturer
where lid IN
        (select lecid
        from section
        group by lecid
        having count(*) > 2 )

-- 









