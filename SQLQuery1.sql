
-- การเข้าถึงข้อมูลแบบ join
select lid,name
from LECTURER,SECTION
where LECTURER.lid = SECTION.sid
and	SECTION.subid = 'CS001'
and SECTION.term = '1-2020'

select lid,name
from lecturer, section,subject
where LECTURER.lid = section.lecid
and section.subid = subject.sid

-- join ข้อมูลซ้ำกัน table เดียวกันตั้งชื่อ table(table แอเรียส) ให้มันใหม่แล้วก็ไปดึงตามตัวอย่าง
-- แสดงรหัสและชื่อวิชา OOP
select	s2.sid,s2.name
from	subject s1, subject s2
where	s1.prerequisite = s2.sid
and		s1.name = 'OOP'




