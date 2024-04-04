-- 테이블 구조 변경
-- ALTER 문 실습

-- 스키마 생성 및 사용
CREATE SCHEMA alter_test;
USE alter_test;

-- 샘플 데이터베이스에서 테이블 구조 복사
CREATE TABLE employees
LIKE employees.employees;

-- 복사한 구조 확인
DESCRIBE employees;
SELECT * FROM employees;

-- 새로운 열을 추가
ALTER TABLE employees ADD COLUMN phone_number VARCHAR(25);

-- 컬럼을 삭제
ALTER TABLE employees DROP COLUMN phone_number;

-- 컬럼명 변경하기
ALTER TABLE employees CHANGE COLUMN first_name FirstName VARCHAR(14);

-- 데이터 타입 변경하기
ALTER TABLE employees MODIFY COLUMN hire_date DATETIME;

-- 데이터 이름 변경하기
ALTER TABLE employees RENAME TO employees_backup;
ALTER TABLE employees_backup RENAME TO employees;

DESCRIBE employees;
-- 제약조건 추가하기
ALTER TABLE employees ADD COLUMN email VARCHAR(255);

-- UNIQUE 제약조건 추가하기
ALTER TABLE employees ADD UNIQUE (email);

-- 1. 참조할 테이블 생성
CREATE TABLE departments (
	drpartment_id INT PRIMARY KEY,
    drpartment_name VARCHAR(100)
);

DESCRIBE employees;
-- 2. 외래키로 사용할 필드를 추가
ALTER TABLE employees ADD COLUMN department_id INT;

-- 3. 외래키 제약조건 추가 (CONSTRAINT 제약조건이름)
ALTER TABLE employees ADD CONSTRAINT fk_department_id
FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- 체크 제약조건 추가
-- 1. 체크할 필드 추가
ALTER TABLE employees ADD COLUMN age INT;

-- 2. 체크 제약조건 추가 (제약조건의 이름을 명시 : CONSTRAINT 제약조건이름)
ALTER TABLE employees ADD CONSTRAINT chk_age
CHECK (age > 19);

-- 열에 대한 설명 추가
ALTER TABLE employees ADD COLUMN salary INT COMMENT '직원의 급여와 관련된 속성';

-- 제약조건 삭제하기
-- 1. 외래키 삭제하기
ALTER TABLE employees DROP FOREIGN KEY fk_department_id;

-- 2. 체크 명시 제약조건 삭제하기
ALTER TABLE employees DROP CONSTRAINT chk_age;

-- ALTER COLUMN 으로 열 속성 변경하기
-- 1. 기본 값 추가
ALTER TABLE employees ALTER COLUMN age SET DEFAULT 20;

-- 2. 기본 값 삭제
ALTER TABLE employees ALTER COLUMN age DROP DEFAULT;