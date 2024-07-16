CREATE TABLE STUDENT(
	sid			char(5),
	name		varchar(30),
	major		char(30),
	gpa			float,
	birthday	date,
CONSTRAINT std_pk		PRIMARY KEY(sid),
CONSTRAINT st_gpa		CHECK (gpa BETWEEN 0.00 AND 4.00),
)

CREATE TABLE SUBJECT(
	sid				char(5),
	name			varchar(30),
	credit			int,
	prerequisite	char(5),
CONSTRAINT sub_pk			PRIMARY KEY(sid),
CONSTRAINT sub_fk_pre		FOREIGN KEY(prerequisite) REFERENCES SUBJECT(sid) ON DELETE NO ACTION,
)

CREATE TABLE LECTURER(
	lid			char(5),
	name		varchar(30),
	salary		int,
	major		varchar(30),
CONSTRAINT lec_pk		PRIMARY KEY(lid),
)

CREATE TABLE SECTION(
	secid		int,
	subid		char(5),
	lecid		char(5),
	term		char(6),
CONSTRAINT sec_pk			PRIMARY KEY(secid),
CONSTRAINT sec_fk_sub		FOREIGN KEY(subid) REFERENCES SUBJECT(sid),
CONSTRAINT sec_fk_lec		FOREIGN KEY(lecid) REFERENCES LECTURER(lid),
CONSTRAINT sec_uk			UNIQUE(subid,lecid,term)
)

CREATE TABLE ENROLL(
	secid	int,
	stdid	char(5),
	grade	char,
CONSTRAINT enroll_fk_sec 	FOREIGN KEY(secid) REFERENCES SECTION(secid),
CONSTRAINT enroll_fk_std 	FOREIGN KEY(stdid) REFERENCES STUDENT(sid),
CONSTRAINT enroll_pk		PRIMARY KEY(secid,stdid),
CONSTRAINT enroll_grade 	CHECK (grade IN ('A','B','C','d','F')),
)

INSERT INTO STUDENT values('50001','jim','CS',3.25,'13-5-1990')
INSERT INTO STUDENT values('50002','Jack','CS',2.25,'15-01-1990')
INSERT INTO STUDENT values('50003','Joe','CS',3.00,'25-06-1990')
INSERT INTO STUDENT(sid,name,major) values('50004','Joy','CS')
INSERT INTO STUDENT values('50005','Jane','PY',2.78,'2-09-1990')
INSERT INTO STUDENT(sid,name,major) values('50006','Peter','CS')

INSERT INTO SUBJECT values('CS001','Programming',3,null)
INSERT INTO SUBJECT values('CS002','Programming 2',3,'CS001')
INSERT INTO SUBJECT values('CS003','Web Programming',3,'CS001')
INSERT INTO SUBJECT values('CS004','Database',3,'CS002')

INSERT INTO LECTURER values('t01','Dumbledore',20000,'CS')
INSERT INTO LECTURER values('t02','Juon',20000,'CS')
INSERT INTO LECTURER values('t03','Ryota',35000,'MA')
INSERT INTO LECTURER values('t04','Peter',20000,'Architecture')

INSERT INTO SECTION values(1,'CS003','t01','1-2020')
INSERT INTO SECTION values(2,'CS005','t01','1-2020')
INSERT INTO SECTION values(3,'CS002','t04','2-2020')
INSERT INTO SECTION values(4,'','t02','1-2011')


sp_help STUDENT
sp_help SUBJECT
sp_help LECTURER
sp_help SECTION
sp_help ENROLL

DROP TABLE STUDENT
DROP TABLE SUBJECT
DROP TABLE LECTURER
DROP TABLE SECTION
DROP TABLE ENROLL

SELECT * FROM  STUDENT
SELECT * FROM  SUBJECT
SELECT * FROM  LECTURER
SELECT * FROM  SECTION
SELECT * FROM  ENROLL