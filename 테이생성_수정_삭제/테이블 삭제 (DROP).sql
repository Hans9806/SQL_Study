-- 테이블 삭제 (DROP)
-- DDL (데이터 정의어)의 일부로 DB 객체를 삭제
-- 명령어를 사용하게 되면, 테이블과 테이블에 포함되어 있는
-- 데이터가 영구적으로 삭제, 주의해서 사용
-- DROP TABLE 테이블명;
USE alter_test;

DROP TABLE employees;
DROP TABLE departments;

-- 데이터베이스(스키마) 삭제
DROP SCHEMA alter_test;

-- 여러 테이블 동시 삭제 (스키마명.테이블명)
DROP TABLE healthcaremanagement.appointments,
			healthcaremanagement.doctors,
			healthcaremanagement.patients;

DROP DATABASE healthcaremanagement;