-- แสดง รหัส ชื่อ และสาขา ของนิสิตทุกคนที่ไม่มีชื่อ
SELECT sid,name,major from STUDENT where name is null

-- แสดง รหัส ชื่อ และสาขา ของนิสิตทุกคนที่ทั้งชื่อ และสาขา ไม่เป็นค่าว่าง
SELECT	sid,name,major 
from	STUDENT 
where	major = 'CS' 
and		name is not null
and		major is not null

-- แสดง รหัส ชื่อ และสาขา ของนิสิตทุกคนที่อยู่ สาขา CS
SELECT	sid,name,major
from	STUDENT
where	major = 'CS'

-- แสดง รหัส ชื่อ และสาขา ของนิสิตทุกคนที่อยู่ สาขา CS หรือ PY
SELECT	sid,name,major
from	STUDENT
where	major in ('CS','PY')

-- แสดง รหัส ชื่อ และสาขา ของนิสิตทุกคนที่ไม่ได้อยู่ สาขา CS, MA, PY
SELECT	sid,name,major
from	STUDENT
where	major not in ('CS','MA','PY')

-- แสดง รหัส ชื่อ และสาขา ของนิสิตทุกคนที่ชื่อขึ้นต้นด้วยตัว S
SELECT	sid,name,major
from	STUDENT
where	name like 'S%'

-- แสดง รหัส ชื่อ และสาขา ของนิสิตทุกคนที่ชื่อขึ้นต้นด้วยตัว K และลงท้ายด้วย A
SELECT	sid,name,major
FROM	STUDENT
WHERE	name like 'K%A'

-- แสดง ชื่อนิสิต สาขา และ gpa ของนิสิตทุกคนที่ gpa อยู่ระหว่าง  2.00 ถึง 3.00
SELECT	name,major,gpa
FROM	STUDENT
WHERE	gpa BETWEEN 2.00 and 3.00

-- แสดง ชื่อนิสิต สาขา และ gpa ของนิสิตทุกคนที่ไม่ได้อยู่ CS หรือ PY เรียงลำดับตาม gpa จากมากไปน้อย
SELECT		name,major,gpa
FROM		STUDENT
WHERE		major not in ('CS','PY')
order by	gpa desc

-- แสดง ชื่อนิสิต สาขา และ gpa ของนิสิตทุกคน เรียงลำดับตาม สาขา และ gpa จากน้อยไปมาก
SELECT	name, major, gpa
FROM	STUDENT
order by major,gpa asc

-- แสดง gpa ที่สูงที่สุด และ ต่ำที่สุดของนิสิต โดยให้แสดงเป็น column ชื่อ max_gpa และ min_gpa
SELECT	max(gpa) as max_gpa,
		min(gpa) as min_gpa
FROM	STUDENT

-- แสดง gpa ที่สูงที่สุด และ gpa ต่ำสุด ของ สาขา CS โดยให้แสดงเป็น column ชื่อ max_cs และ min_cs
SELECT	max(gpa) as max_cs,
		min(gpa) as min_cs
FROM	STUDENT
WHERE	major = 'CS'

-- แสดงรหัสวิชาที่เป็น prerequisite ของวิชา Graphics
SELECT	sid 
FROM	SUBJECT
WHERE	name = 'Graphics'

-- แสดงรหัสและชื่อวิชา ของวิชาที่ไม่มีวิชา prerequisite
SELECT	sid,name
FROM	SUBJECT
WHERE	prerequisite is null

-- วิชาใดบ้างที่มีหน่วยกิต 3 หน่วยกิตขึ้นไป
SELECT	* 
FROM	SUBJECT
WHERE	credit>=3.00

-- วิชาใดบ้างที่มีวิชา CS001 เป็นวิชา prerequisite
SELECT	*
FROM	SUBJECT
WHERE	prerequisite = 'CS001'

-- มีกี่วิชาที่วิชารหัส CS001 เป็นวิชา prerequisite
SELECT	count(*) as Count_prerequisite_ID
FROM	SUBJECT
WHERE	prerequisite = 'CS001'

-- แสดงข้อมูลอาจารย์ที่ได้เงินเดือนระหว่าง 20000 – 40000
SELECT	* 
FROM	LECTURER
WHERE	salary BETWEEN 20000 and 40000

-- เงินเดือนที่สูงที่สุดของอาจารย์สาขา CS คือเท่าไร
SELECT	max(salary) as max_CS
FROM	LECTURER
WHERE	major = 'CS'

-- เงินเดือนเฉลี่ยของอาจารย์ในสาขา English คือเท่าไร
SELECT	avg(salary) as average_ENG
FROM	LECTURER
WHERE	major = 'English'


-- อาจารย์ในสาขา English ใครบ้างที่ได้เงินเดือนต่ำกว่า 40000 บาท
SELECT	*
FROM	LECTURER
WHERE	salary <= 40000	

-- แสดงข้อมูลอาจารย์ที่อยู่ภาควิชาอื่น ๆ ที่ไม่ใช่ CS หรือ MIS
SELECT	*
FROM	LECTURER
WHERE	major not in ('CS','MIS')

-- แสดงเงินเดือนรวมทั้งหมด, เงินเดือนสูงสุด, เงินเดือนต่ำสุด , ค่าเฉลี่ยเงินเดือน ของอาจารย์ 
-- โดยให้แสดงเป็น column ชื่อ total_salary, max_salary, min_salary และ average_salary
SELECT	sum(salary) as total_salary,
		max(salary) as max_salary,
		min(salary) as min_salary,
		avg(salary) as average_salary
FROM	LECTURER

-- แสดงเงินเดือนรวมทั้งหมด, เงินเดือนสูงสุด, เงินเดือนต่ำสุด , ค่าเฉลี่ยเงินเดือน ของอาจารย์สาขา English
-- โดยให้แสดงเป็น column ชื่อ total_sal, max_sal, min_sal และ average_sal
SELECT	sum(salary) as total_salary,
		max(salary) as max_salary,
		min(salary) as min_salary,
		avg(salary) as average_salary
FROM	LECTURER
WHERE	major = 'English'

-- แสดงรหัสอาจารย์ที่สอนวิชา CS001 เทอม 1-2020
SELECT	secid
FROM	SECTION
WHERE	subid = 'CS001'
and		term = '1-2020'

-- section รหัสใดบ้างที่เปิดสอนวิชารหัส CS001
SELECT	*
FROM	SECTION
WHERE	subid = 'CS001'

-- เทอม 1-2021 เปิดสอนทั้งหมดกี่วิชา
SELECT	count(distinct subid) as count_1_2021
FROM	SECTION
WHERE	term = '1-2021'

-- แสดงจำนวนวิชาที่เปิดสอนปี 2020
SELECT	count(distinct subid) as count_2020
FROM	SECTION
WHERE	term like '%2020'

-- แสดง section id, subject id, lecturer id และ เทอม ของการสอนที่เปิดสอนทุกเทอมในปี 2020
SELECT	secid,subid,lecid,term 
FROM	SECTION
WHERE	term like '%2020'

-- แสดง รหัสวิชา ที่เปิดสอนในปี 2020 ( ทั้ง  1-2020 และ 2-2020 ) โดยไม่แสดงรหัสซ้ำกัน
SELECT	distinct subid
FROM	SECTION
WHERE	substring(term,3,4) = '2020'

-- แสดงรหัสวิชาที่สอนโดยอาจารย์รหัส t01 โดยแสดงรหัสไม่ซ้ำกัน
SELECT	distinct subid
FROM	SECTION
WHERE	lecid = 't01'

-- อาจารย์รหัส t02 เคยสอนทั้งหมดกี่ครั้ง
SELECT	count(*) as count_t02
FROM	SECTION
WHERE	lecid = 't02'

-- วิชารหัส CS005 เคยเปิดสอนทั้งหมดกี่ครั้ง
SELECT	count(*) as count_CS005
FROM	SECTION
WHERE	subid = 'CS005'

-- แสดงรหัสนิสิตที่ได้เกรด A โดยแสดงรหัสไม่ซ้ำกัน
SELECT	distinct stdid
FROM	ENROLL
WHERE	grade = 'A'

-- แสดงรหัสนิสิตที่ลงทะเบียนเรียนคอร์ส section id 5
SELECT	stdid
FROM	ENROLL
WHERE	secid = '5'

-- แสดงรหัสนิสิตที่ลงทะเบียนเรียนคอร์ส section id 1 และเกรดไม่เป็น F
SELECT	stdid
FROM	ENROLL
WHERE	secid = '1'
and		grade != 'F'

-- แสดงจำนวนนิสิตที่ลงทะเบียนเรียน section 2 และ เกรดไม่เป็น F
SELECT	stdid
FROM	ENROLL
WHERE	secid = '2'
and		grade <> 'F'


-- แสดงจำนวนครั้งที่นิสิตรหัส 60001 ลงทะเบียนเรียน
SELECT	count(*) as count_stdid_60001
FROM	ENROLL
WHERE	stdid = '60001'

-- แสดงจำนวนครั้งที่นิสิตรหัส 60006 ได้เกรด F
SELECT	count(*) as count_stdid_60006_gradeF
FROM	ENROLL
WHERE	stdid = '60006'
and		grade = 'F'

SELECT	* FROM	STUDENT
-- แสดง รหัส ชื่อ และวันเกิด ของนิสิตทุกคนที่เกิดปี 2005
SELECT	sid,name,birthday
FROM	STUDENT
WHERE	YEAR(birthday) = '2005'

-- แสดง รหัส ชื่อ และวันเกิด ของนิสิตทุกคนที่มีอายุ 20 ปีขึ้นไป
SELECT	sid,name,birthday
FROM	STUDENT
WHERE	DATEDIFF(YEAR,birthday, GETDATE()) > 20

-- แสดง รหัสนิสิต และชื่อ ของนิสิตทุกคนที่เกิดเดือน September
SELECT	sid,
		name,
		DATENAME(month,birthday) as month_birthday
FROM	STUDENT
WHERE	DATENAME(month,birthday) = 'กันยายน'

SELECT DATENAME(month,GETDATE())

-- แสดง รหัสนิสิต ชื่อ และอายุ ของนิสิตทุกคนที่เกิดวันพฤหัสบดี
SELECT	sid,
		name,
		DATEDIFF(year,birthday,GETDATE()) as Age,
		DATENAME(WEEKDAY,birthday) 
FROM	STUDENT
WHERE	DATENAME(WEEKDAY,birthday) = 'พฤหัสบดี'

-- แสดง รหัสนิสิต ชื่อ ปีเกิด และ อายุ ของนิสิตทุกคน
SELECT	sid,
		name,
		birthday,
		DATEDIFF(year,birthday,GETDATE()) as Age
FROM	STUDENT

-- แสดง รหัสนิสิต ชื่อ สาขา ปีเกิด, อายุ ของนิสิตที่อายุน้อยกว่า 20 ปี และไม่ได้อยู่ สาขา CS
SELECT	sid,
		name,
		major,
		birthday,
		DATEDIFF(year,birthday,GETDATE()) as Age
FROM	STUDENT
WHERE	DATEDIFF(year,birthday,GETDATE()) <= 20
and		major != 'CS'

-- ISNULL, TOP, Group by - having
-- แสดงข้อมูลของนิสิต ที่ได้ GPA สูงที่สุดใน major CS
SELECT	max(gpa)
FROM	STUDENT
WHERE	major = 'CS'

-- แสดงข้อมูลของอาจารย์ที่เงินเดือนน้อยที่สุด 2 คน
select	top 2 * 
from	lecturer
order by salary asc

-- แสดงรหัสอาจารย์ และจำนวนครั้งที่เคยสอน 
select		lecid,
			count(*) as count
from		section
group by	lecid

-- แสดงรหัสอาจารย์ และจำนวนครั้งที่เคยสอน โดยแสดงเฉพาะอาจารย์ที่สอนมากที่ 3 คน
select		top 3 lecid,
			count(*) as count
from		section
group by	lecid 

-- แสดงรหัสวิชา ชื่อวิชา และ รหัสวิชาเงื่อนไข ถ้าวิชาใดไม่มีวิชาเงื่อนไข ให้แสดงข้อความ  ไม่มีวิชาเงื่อนไข
select	sid,name,cast(
		case
			when prerequisite is null then 'ไม่มีวิชาเงื่อนไข'
			else prerequisite
		end as varchar(20))as 'วิชาเงื่อนไข'
from	subject

-- แสดง ชื่อmajor , gpa สูงสุดของ major นั้น ๆ และ gpa ต่ำสุดของ major นั้น ๆ 
-- โดยไม่แสดงข้อมูลที่ major เป็น null
-- ตัวอย่างการแสดงผล
-- major	Max_GPA	Min_GPA
-- Art		3.98		3.05
-- CS		3.98		1.55
-- PY		2.85		1.50
-- Thai		2.78		2.78
select * from student
select		major,
			max(gpa) as max_GPX,
			min(gpa) as min_GPA
from		student
where		major is not null
group by	major

-- แสดง ชื่อ major, gpa สูงสุดของ major นั้น ๆ และ gpa ต่ำสุดของ major นั้น ๆ 
-- โดยแสดงเฉพาะ major ที่มีค่า gpa ต่ำสุด มากกว่า 2.00
-- ตัวอย่างการแสดงผล
-- major	Max_GPA	Min_GPA
-- Art		3.98		3.05
-- Thai		2.78		2.78
select		major,
			max(gpa) as Max_GPA,
			min(gpa) as Min_GPA
from		student
where		gpa > 2
group by	major

-- แสดง ชื่อ major, จำนวนนิสิตใน major นั้น, gpa สูงสุดของ major นั้น และ gpa ต่ำสุดของ major นั้น 
-- โดยแสดงเฉพาะ major ที่มีจำนวนนิสิตมากกว่า 1 คน และ gpa ต่ำสุดของ major นั้นมากกว่า 1.5
-- และ  major ไม่เป็น null
-- เรียงลำดับตาม จำนวนนิสิตจากมากไปน้อย
select * from student

select		major,
			count(*) as count_student,
			max(gpa) as Max_GPA,
			min(gpa) as Min_GPA
from		student
where		gpa > 1.5
and			major is not null
group by	major

-- แสดงปีเกิด และจำนวนนิสิตที่เกิดปีนั้น โดยแสดงเฉพาะที่ปีไม่เป็น null
select		year(birthday),
			count(*) as count_day
from		student
where		birthday is not null
group by	year(birthday)

SELECT * FROM ENROLL
-- แสดง รหัสนิสิต, และจำนวนครั้งที่ลงเรียน 
SELECT 		stdid,
			count(*) as count_learn
FROM 		ENROLL
GROUP BY 	stdid

-- แสดง รหัสวิชา, และจำนวนครั้งที่เคยเปิดสอน
SELECT 		subid,
			COUNT(*) as count_open
FROM 		SECTION
GROUP BY 	subid

-- แสดง เกรด, จำนวนครั้งที่ได้เกรดนั้น ๆ ของนิสิตรหัส 60001
SELECT	 	grade,
			COUNT(*) as count_grade
FROM	 	ENROLL
WHERE	 	stdid = '60001'
GROUP BY 	grade

select * from student
select * from enroll
select * from section
select * from subject
select * from lecturer

-- แสดง รหัสนิสิต และ จำนวนครั้งที่ได้เกรด F ของนิสิตรหัสนั้น ๆ  
SELECT		 	stdid,
				COUNT(grade) as count_gradeF
FROM			enroll
WHERE 			grade = 'F'
GROUP BY 		stdid

-- แสดง รหัสนิสิต และ จำนวนครั้งที่ได้เกรด F โดยแสดงเฉพาะนิสิตที่ได้เกรด F มากกว่า 1 ครั้ง
SELECT 		stdid,
			COUNT(grade) as count_gradeF
FROM 		ENROLL
WHERE 		grade = 'F'
GROUP BY 	stdid
having  	COUNT(*) > 1

-- แสดงรหัสอาจารย์ที่เคยสอนมากกว่า 3 ครั้ง
SELECT 		lecid,
			COUNT(*) as count_learn
FROM 		SECTION
GROUP BY 	lecid
HAVING 		COUNT(*) > 3

-- แสดงรหัสอาจารย์ที่เคยสอนวิชา CS001 มากกว่า 1 ครั้ง
SELECT 		lecid
FROM 		SECTION
WHERE 		subid = 'CS001'
GROUP BY	lecid
HAVING		COUNT(lecid) > 1 

-- แสดงรหัสอาจารย์ รหัสวิชา และจำนวนครั้งที่อาจารย์เคยสอนวิชานั้น  
-- โดยแสดงเฉพาะที่มีสอนมากกว่า 1 ครั้ง เรียงลำดับตามรหัสอาจารย์
SELECT 		lecid,
			subid,
			COUNT(lecid) as count_subject
FROM 		SECTION
GROUP BY 	lecid,subid
HAVING		COUNT(subid) > 1
ORDER BY 	SUBSTRING(lecid,2,3) DESC

-- Select , update statement with CASE
-- แสดง ข้อมูลของนิสิต โดยสนใจนิสิตที่ตรงตามเงื่อนไขนี้
-- ถ้าอยู่สาขา cs 	ได้ gpa > 3.00
-- ถ้าอยู่สาขา py 	ได้ gpa > 3.20
-- ถ้าอยู่สาขา art 	ได้ gpa > 3.50
SELECT 	* FROM 	STUDENT
UPDATE STUDENT 
set GPA =
	case
		when major = 'cs' 	then 3.00
		when major = 'py' 	then 3.20
		when major = 'art' 	then 3.50 
	end

-- แสดงรหัสนิสิต ชื่อ และอายุของนิสิต โดยสนใจนิสิตที่ตรงตามเงื่อนไขนี้
-- ถ้าอยู่สาขา cs  			อายุ > 18 ปี
-- ถ้าอยู่สาขา Art	  		อายุ > 19 ปี
-- ถ้าอยู่สาขา English  	อายุ > 17 ปี
-- ถ้าอยู่สาขาอื่น ๆ  		  อายุ > 20 ปี
SELECT 	* 
FROM 	STUDENT
WHERE 	DATEDIFF(YEAR,birthday,GETDATE()) > 
case
	when major = 'cs' 		then 18
	when major = 'art'		then 19
	when major = 'English'	then 17
	else 20 
end

-- เพิ่มเงินเดือนให้อาจารย์ โดยเพิ่มตามเงื่อนไขคือ
-- ถ้าอาจารย์ได้เงินเดือน <= 30000 บาท 	เพิ่มเงินเดือนให้ 	20 %
-- ถ้าอาจารย์ได้เงินเดือน 30001 - 40000 บาท 	เพิ่มเงินเดือนให้  10 %
-- ถ้าอาจารย์ได้เงินเดือน 40001 - 50000 บาท 	เพิ่มเงินเดือนให้ 	 5 %
-- ถ้าอาจารย์ได้เงินเดือนสูงกว่า 50000 บาท 	ไม่ต้องเพิ่มเงินเดือน
SELECT * FROM LECTURER
UPDATE LECTURER SET salary = 
case
	when salary <= 	30000 then salary * 1.2
	when salary < 	40000 then salary * 1.1
	when salary < 	50000 then salary * 1.05
	else salary
end
SELECT * FROM LECTURER
