-- 뷰
USE SCOTT;

SELECT * FROM emp;

-- 뷰 생성
CREATE VIEW view_emp AS
SELECT empno, ename, job, deptno FROM emp;

-- 생성된 뷰는 새로운 가상의 테이블처럼 접근
SELECT * FROM view_emp;

-- 뷰의 삭제
DROP VIEW view_emp;

-- 1. 뷰의 장점 : 보안에 도움이 됨, 사용자에게 보여주고 싶은 속성만 보여줄 수 있음
-- 뷰로 조건부 데이터 선택
CREATE VIEW view_emp_30 AS
SELECT * FROM emp WHERE deptno = 30;

-- 일반 테이블처럼 조회하여 사용할 수 있음.
SELECT * FROM view_emp_30;
SELECT ename FROM view_emp_30;

-- 2. 복잡한 쿼리를 단순화 시켜줄 수 있음.

SELECT * FROM emp;
SELECT * FROM dept;

-- 사원 이름과 부서이름의 가상테이블
CREATE VIEW emp_dept_view AS
SELECT 
    e.ename AS employee_name, d.dname AS department_name
FROM
    emp e
        INNER JOIN
    dept d ON e.deptno = d.deptno;

-- 2개 이상의 테이블이 조인된 복잡한 쿼리도 결과셋을 뷰로 단순화시킬 수 있음.
-- 쿼리 결과 셋의 컬럼의 별칭은 뷰의 컬럼의 컬럼명이 된다.
SELECT employee_name, department_name FROM emp_dept_view;


-- 뷰 실습
use sqldb;
select * from usertbl;
select * from buytbl;

-- 뷰 생성시 열의 정보를 내장함수로 조작할 수 있고, 컬럼명도 별칭으로 변경할 수 있음.
CREATE VIEW view_userbuytbl AS
    SELECT 
        u.userid AS `User Id`,
        u.name AS `User Name`,
        b.prodName AS `Product Name`,
        u.addr AS `User Address`,
        CONCAT(u.mobile1, u.mobile2) AS `Mobile Phone`
    FROM
        usertbl u
            INNER JOIN
        buytbl b ON u.userid = b.userid;

-- 뷰를 테이블처럼 사용 가능
SELECT * FROM view_userbuytbl;
SELECT `User Id`, `User Name` FROM view_userbuytbl;

-- CREATE OR REPLACE VIEW
-- 기존의 동일 이름의 뷰가 있으면 오류 발생하지 않고, 덮어쓰기
CREATE OR REPLACE VIEW view_usertbl AS
	SELECT userid, name, addr FROM usertbl;

-- 동일하게 테이블처럼 정보를 확인할 수 있음
DESC usertbl;		
DESC view_usertbl;		-- 데이터 타입은 동일하지만 기본키 등의 정보는 확인되지 않음.
select * from usertbl;

-- 뷰의 생성문(소스코드)를 확인하기
SHOW CREATE VIEW view_usertbl;

-- 뷰를 통해서 데이터를 수정하기 => 원본 테이블의 제약조건 문제가 없어서 성공적 변경
-- 원본 테이블의 정보가 변경된다.
SELECT * FROM view_usertbl;	-- 데이터 확인
UPDATE view_usertbl 
SET 
    addr = '부산'
WHERE
    userid = 'JKW';

-- 뷰를 통해서 데이터를 입력하기
-- 원본 테이블의 제약조건(birthYear, Not Null)을 만족시킬 수 없기 때문에
-- 뷰를 통한 새로운 데이터 삽입은 불가능
INSERT INTO view_usertbl(userid, name, addr)
VALUES ('HKD', '홍길동', '제주');


-- 그룹 함수를 포함하는 뷰 생성
CREATE OR REPLACE VIEW view_sum AS
SELECT userid, sum(price*amount) as 'total'
FROM buytbl
GROUP BY userid;

SELECT * FROM view_sum;
-- 그룹 함수를 사용한 집계함수 컬럼은 수정할 수 없다.
-- 시스템에 저장된 뷰 정보를 통해 확인했을 때 IS_UPDATABLE이 NO
-- => 데이터 수정 불가
SELECT * FROM information_schema.views
	WHERE table_schema = 'sqldb';
-- 집계함수를 사용하는 뷰, JOIN을 사용하는 뷰, UNION ALL(합집합)을 사용하는 뷰
-- DISTINCT 사용, GROUP BY 사용 => 데이터 수정이나 삭제가 불가

-- CEHCK_OPTION
CREATE VIEW view_height_upper177 AS
SELECT * FROM usertbl WHERE height >= 177;

SELECT * FROM view_height_upper177;

SELECT * FROM information_schema.views
	WHERE table_schema = 'sqldb';

-- 뷰에서 177 미만 키를 삭제 (데이터가 없기 때문에 삭제되지 않음)
DELETE FROM view_height_upper177
WHERE height < 177;

-- 원본의 177미만의 데이터는 남아있음.
SELECT * FROM usertbl;

-- 뷰에서 데이터 삽입 (도메인 제약조건에 맞게) => 데이터 삽입 성공
INSERT INTO view_height_upper177
VALUES ('SDR', '숏다리', 1990, '부산', '010', '11111111', 150, '2024-01-01');

-- 뷰의 SELECT 문에 뷰에서 삽입한 데이터가 조건에 해당하지 않기 때문에
SELECT * FROM view_height_upper177;	-- => 조회불가

-- 원본 데이터에서는 삽입이 되었음 => (뷰에서는 조회, 수정, 삭제 불가)
SELECT * FROM usertbl;

-- 뷰 수정
-- 뷰에서 키가 177 미만인 데이터가 입력되지 않게 끔
-- WITH CHECK OPTION
ALTER VIEW view_height_upper177 AS
	SELECT * FROM usertbl WHERE height >= 177
		WITH CHECK OPTION;

-- 뷰를 통해 데이터 삽입 
-- => CHECK OPTION으로 데이터 삽입 실패 => 의도하지 않은 경로 삽입을 막음 => 무결성 지킴
INSERT INTO view_height_upper177
VALUES ('SDL', '숏다리2', 1990, '부산', '010', '22222222', 140, '2024-01-01');

-- CHECK_OPTION이 활성화
SELECT * FROM information_schema.views
	WHERE table_schema = 'sqldb';
    
-- 조인을 한 뷰는 업데이트 불가
SHOW CREATE VIEW view_userbuytbl;

SELECT * FROM view_userbuytbl;

-- 도메인 제약조건에 맞게 삽입하여도 조인한 뷰에서는 삽입이 불가
INSERT INTO view_userbuytbl
VALUES ('ABC', '가나다', '모니터', '서울', '01012345678');

-- 원본 테이블이 삭제되는 경우, 뷰는 조회할 수 없다
DROP TABLE IF EXISTS buytbl, usertbl;	-- 테이블 삭제

SELECT * FROM view_usertbl;	-- 참조 불가로 인해 조회 불가

CHECK TABLE view_usertbl;	-- 뷰의 상태 체크 결과 => Error

DROP VIEW view_sum, view_height_upper177, view_userbuytbl, view_usertbl;