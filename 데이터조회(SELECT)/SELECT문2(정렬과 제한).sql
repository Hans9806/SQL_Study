-- 정렬 및 결과 제한
USE SCOTT;
-- ORDER BY
-- SELECT 컬럼명, ...
-- FROM 테이블명
-- ORDER BY 컬럼명1 ASC|DESC (오름차순|내림차순), 컬럼명2 ASC|DESC, ...;
-- 특정 컬럼의 값에 따라 오름차순(ASC) 또는 내림차순(DESC)로 정렬
-- 기본적으로 ASC은 디폴트값이라서 생략 가능

-- (단일열 정렬) 급여가 많은 순으로 조회
SELECT ENAME, SAL FROM EMP
ORDER BY SAL DESC;

-- (두개 이상의 열 정렬) 부서순으로 먼저 정렬하고, 급여순 정렬
SELECT ENAME, DEPTNO, SAL FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;
-- ASC 생략 가능
SELECT ENAME, DEPTNO, SAL FROM EMP
ORDER BY DEPTNO, SAL DESC;

-- LIMIT 출력하는 결과 개수를 제한
-- SELECT 컬럼명 ... FROM 테이블명
-- LIMIT 제한할 행의 갯수;

-- 가장 급여를 많이 받는 TOP5
SELECT ENAME, SAL FROM EMP
ORDER BY SAL DESC
LIMIT 5;

-- OFFSET : 몇번째 행부터 데이터를 반환할지를 지정
-- LIMIT와 함께 사용되며, 데이터 페이지네이션(Pagenation)
-- SELECT 컬럼명 ... FROM 테이블명
-- LIMIT 제한할 행의 갯수 OFFSET 시작할 행의번호;

-- 첫 번째 행은 0

-- 가장 급여를 많이 받는 6위 10위까지
SELECT ENAME, SAL FROM EMP
ORDER BY SAL DESC
LIMIT 5 OFFSET 5;

-- LIMIT ~ OFFSET 은 대규모의 데이터셋에서 필요한 부분만 조회하여
-- 응답시간 및 성능을 최적화하여 사용자 경험을 개선할 수 있음
-- 페이지네이션을 구현하여 효율적인 데이터 관린에 사용