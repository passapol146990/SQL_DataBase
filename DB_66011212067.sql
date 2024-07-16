SELECT * FROM INFORMATION_SCHEMA.TABLES where table_schema like 'DB_66011212067'


CREATE TABLE DEPARTMENT(
	did		char(10),
	name	varchar(50),
	room	varchar(10),
CONSTRAINT dept PRIMARY KEY(did),
)

SELECT * FROM DEPARTMENT
DROP TABLE DEPARTMENT


CREATE TABLE EMPLOYEE(
	eid			char(10),
	name		varchar(50),
	gender		varchar(10),
	idcard		char(20),
	salary		float,
	birthday	date,
	dept		char(10),
CONSTRAINT emp_id PRIMARY KEY(eid),
CONSTRAINT emp_idcard UNIQUE(idcard),
CONSTRAINT emp_
)

sp_help
