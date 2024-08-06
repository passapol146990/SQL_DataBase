--Join and Nested Statement

-- แสดงรหัสนิสิต และชื่อนิสิตที่เคยเรียนวิชา CS001
select	student.sid,
		student.name
from	student, enroll, section
where	student.sid	 = enroll.stdid
and		enroll.secid = section.secid
and		section.subid = 'CS001'

-- แสดงรหัสนิสิต และชื่อนิสิตที่เคยเรียนวิชา Programming
select	student.sid,
		student.name,
		subject.name
from	student, enroll, section, subject
where	student.sid		= enroll.stdid
and		enroll.secid	= section.secid
and		section.subid	= subject.sid
and		subject.name	= 'Programming'

-- แสดงรหัสนิสิต และชื่อนิสิตที่เคยเรียนกับอาจารย์ชื่อ Peter Parker
select	student.sid,
		student.name,
		lecturer.name
from	student, enroll, section, lecturer
where	student.sid		= enroll.stdid
and		enroll.secid	= section.secid
and		section.lecid		= lecturer.lid
and		lecturer.name	= 'Peter Parker'

-- แสดง รหัสนิสิต ที่ได้เกรด A วิชา Programming
select	enroll.stdid,
		enroll.grade,
		subject.name
from	enroll, section, subject
where	enroll.secid	= section.secid
and		section.subid	= subject.sid
and		enroll.grade	= 'A'
and		subject.name	= 'Programming'

-- แสดง รหัสนิสิต และชื่อนิสิต ที่ได้เกรด A วิชา Programming
select	student.sid,
		enroll.grade,
		subject.name
from	student, enroll, section, subject
where	student.sid		= enroll.stdid
and		enroll.secid	= section.secid
and		section.subid	= subject.sid
and		enroll.grade	= 'A'
and		subject.name	= 'Programming'

-- แสดงรหัสนิสิต ชื่อนิสิต และเกรดที่ได้ ของนิสิตที่เรียน section id 6 
select	student.sid,
		student.name,
		enroll.grade,
		enroll.secid
from	student, enroll
where	student.sid		= enroll.stdid
and		enroll.secid	= 6


-- แสดงรหัสนิสิต ชื่อนิสิต และเกรดที่ได้ ของนิสิตที่เรียนวิชา Database ในเทอม 1-2020
select	student.sid,
		student.name,
		enroll.grade,
		subject.name,
		section.term
from	student, enroll, section, subject
where	student.sid		= enroll.stdid
and		enroll.secid	= section.secid
and		section.subid	= subject.sid
and		subject.name	= 'Database'
and		section.term	= '1-2020'


-- แสดงรหัสนิสิต และชื่อนิสิตของนิสิตที่เคยเรียนวิชา cs001 หรือ cs002
select	student.sid,
		student.name,
		section.subid
from	student, enroll, section
where	student.sid		= enroll.stdid
and		enroll.secid	= section.secid
and		section.subid	in ('cs001','cs002')

-- แสดงชื่อวิชาและเทอมที่เปิดสอน เรียงลำดับตามเทอม
select	subject.name,
		section.term
from	subject, section
where	subject.sid  = section.subid
order	by substring(section.term,3,4), substring(section.term,1,1)

-- แสดงวิชา , เทอมที่เรียน , อาจารย์ผู้สอน และเกรดที่ได้ ของนิสิตชื่อ Rukawa
select	subject.name,
		section.term,
		lecturer.name,
		enroll.grade,
		student.name
from 	student, enroll, section, subject, lecturer
where	student.name	= 'Rukawa'
and		enroll.stdid	= student.sid
and		section.secid	= enroll.secid
and 	subject.sid		= section.subid
and		lecturer.lid	= section.lecid

select * from student
select * from enroll
select * from section
select * from subject
select * from lecturer
	
-- แสดงชื่อวิชา, เทอมที่สอน, ชื่อผู้สอน ของทุกวิชาที่สอนโดยอาจารย์ใน major CS
select	subject.name,
		section.term,
		lecturer.name
from	lecturer, section, subject																		
where	lecturer.major 	= 'CS'
and		section.lecid 	= lecturer.lid
AND		subject.sid 	= section.subid
order by substring(section.term,3,4), substring(section.term,1,1)

-- แสดง รหัสนิสิต, ชื่อนิสิต, ชื่อวิชา, ชื่อผู้สอน, เทอมที่เรียน ของการเรียนที่ได้เกรด F
SELECT 	STUDENT.sid,
		STUDENT.name,
		SUBJECT.name,
		LECTURER.name,
		SECTION.term
FROM 	STUDENT, ENROLL, SECTION, SUBJECT, LECTURER
WHERE	ENROLL.grade = 'F'
AND		STUDENT.sid = ENROLL.stdid
AND		SECTION.secid = ENROLL.secid
AND		SUBJECT.sid  = SECTION.subid
AND		LECTURER.lid = SECTION.lecid																														

-- แสดงรหัสวิชา และชื่อวิชาที่เป็น pre-requisite ของวิชารหัส cs002
SELECT s1.sid,s1.name
FROM SUBJECT s1, SUBJECT s2
WHERE 	s2.prerequisite = 'cs002'
AND 	s1.sid = s2.sid

-- แสดงรหัสวิชา และชื่อวิชาที่เป็น pre-requisite ของวิชา AI
SELECT 	s1.sid, s1.name
FROM   	SUBJECT s1, SUBJECT s2
WHERE 	s2.name = 'AI'
AND 	s1.sid = s2.prerequisite

SELECT * FROM SUBJECT
-- แสดงรหัสวิชา และชื่อวิชาของทุกวิชาที่มีวิชา programming เป็น pre-requisite
SELECT  s1.sid, s1.name
FROM 	SUBJECT s1, SUBJECT s2
WHERE	s2.name 		= 'Programming'
AND		s1.prerequisite = s2.sid

-- Outer Join
-- แสดงชื่ออาจารย์และเทอมที่สอน ของอาจารย์ทุกคน รวมทั้งอาจารย์ที่ไม่เคยสอนเลย
-- แสดงชื่ออาจารย์ ชื่อวิชาที่สอน และเทอมที่สอน ของอาจารย์ทุกคน รวมทั้งอาจารย์ที่ไม่เคยสอนเลย
-- โดยถ้าอาจารย์คนใดไม่เคยสอนเลย ให้แสดงข้อความ ไม่เคยสอน ในคอลัมน์ วิชา และเทอมที่สอน
-- แสดงรหัสนิสิต และรหัสวิชาที่ลงทะเบียนเรียน ของนิสิตทุกคน รวมทั้งคนที่ไม่เคยลงทะเบียนเรียนเลย
-- แสดงรหัสนิสิต ชื่อวิชาเทอมที่เรียน เกรดที่ได้ ของนิสิตทุกคน รวมทั้งคนที่ไม่เคยลงทะเบียนเรียนเลย

-- INTERSECT, EXCEPT,  UNION
-- แสดงรหัสนิสิต และชื่อนิสิตของนิสิตที่เคยเรียนทั้งวิชา cs001 และ cs002  
-- แสดงรหัสนิสิต และชื่อนิสิตของนิสิตที่เคยเรียนวิชา cs001 แต่ไม่เคยเรียน cs002
-- แสดง ชื่อ, สาขา ของอาจารย์ที่สอนในเทอม 1-2020 แต่ไม่ได้สอนเทอม 2-2020
-- แสดงรหัสและชื่ออาจารย์ที่สอนวิชา Programming แต่ไม่เคยสอน Database
-- แสดงรหัสและชื่อนิสิตที่เคยเรียน Programming แต่ไม่เคยเรียน Graphics
-- แสดง ชื่อ, ปีเกิด, อายุ ของนิสิตที่อายุน้อยที่สุด และอายุมากที่สุด
-- แสดง ชื่อ, ปีเกิด, อายุ ของนิสิตที่อายุน้อยที่สุด และอายุมากที่สุดใน major CS
-- แสดงข้อมูลของนิสิตสาขา CS ที่ไม่เคยเรียนวิชา Programming เลย

-- Nested Join Statement
-- แสดงชื่อของอาจารย์ภาควิชา CS ที่ไม่เคยสอนวิชา Programming
-- แสดงจำนวนนิสิตที่ลงทะเบียนเรียนในเทอม 2-2020 (จากข้อ 2. ให้นับเฉพาะจำนวนนิสิต )
-- แสดง รหัสอาจารย์และชื่อ ของอาจารย์ที่ไม่ได้สอนในภาคเรียน 1-2020
-- แสดง name, ปีเกิด, อายุ ของนิสิตที่อายุน้อยที่สุด
-- แสดง name, ปีเกิด, อายุ ของนิสิตที่อายุมากที่สุด ใน major CS
-- แสดง ข้อมูล ของนิสิตที่ได้ GPA สูงที่สุดในมหาวิทยาลัย
-- แสดง ข้อมูล ของนิสิตที่ได้ GPA สูงที่สุดใน major CS
-- แสดง ข้อมูล ของนิสิตที่ได้ GPA สูงที่สุดใน major Thai
-- แสดง ข้อมูล ของ นิสิตที่เคยลงทะเบียนเรียน และไม่เคยติด F เลย
-- แสดงรหัสวิชาและ ชื่อวิชา ที่ไม่เคยเปิดสอนเลย
-- Group by , Having,  Exists

-- แสดง รหัสนิสิต, และจำนวนครั้งที่ลงเรียน เฉพาะนิสิตที่อยู่ major CS
-- ตัวอย่างการแสดงผล
-- stdid		Amount
-- 50001		5
-- 50002		4
-- 50003		4
-- 50004		2

-- แสดง เกรด, จำนวนครั้งที่ได้เกรดนั้น ๆ ของนิสิตชื่อ Sakuragi
-- ตัวอย่างการแสดงผล
-- grade		Amount
-- A		1
-- B		2
-- 	F		1

-- แสดงข้อมูลทุกอย่างของอาจารย์ที่เคยสอนมากกว่า 3 ครั้ง
-- ตัวอย่างการแสดงผล
-- 	lid		name			salary		major
-- 	t01		Peter Parker		40000		CS
-- 	t02		Steve Roger		50000		CS
-- 	t03		Edward Norton	55000		MIS
-- 	t05		Iron Man		65000		MIS

-- แสดงข้อมูลของอาจารย์ CS ที่เคยสอนวิชา Programming มากกว่า 2 ครั้ง
-- แสดงรหัสอาจารย์ เทอมที่สอน และจำนวนวิชาที่สอนในเทอมนั้น
-- เฉพาะอาจารย์ที่สอนมากกว่า 1 วิชาในเทอมนั้น โดยเรียงลำดับตามรหัสอาจารย์
