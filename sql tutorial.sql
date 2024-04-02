-- 데이터 선택하여 활용
SELECT * FROM PRODUCTTBL;
SELECT MEMBERNAME, MEMBERADDRESS FROM MEMBERTBL;
SELECT * FROM MEMBERTBL WHERE MEMBERNAME = '지운이';

-- 테이블의 생성과 삭제
CREATE TABLE `my test_tbl` (id INT);
DROP TABLE `my test_tbl`;

-- 인덱스 생성 (데이터 삽입 및 비교)
CREATE TABLE INDEX_TBL (
	first_name varchar(14),
    last_name varchar(16),
    hire_date date
    );
INSERT INTO INDEX_TBL
	SELECT first_name, last_name, hire_date
    FROM employees.employees
	LIMIT 500;
SELECT * FROM INDEX_TBL;

SELECT * FROM index_tbl WHERE first_name = 'Mary';

CREATE INDEX IDX_INDEX_TBL_FIRSTNAME
	ON INDEX_TBL(FIRST_NAME);

-- 사용자 뷰 만들기    
CREATE VIEW uv_member_tbl
AS
	SELECT memberName, memberAddress
    FROM membertbl;

SELECT * FROM uv_member_tbl;

-- 테이블 데이터 삭제 및 복구
DELETE FROM producttbl;

SELECT * FROM producttbl;



