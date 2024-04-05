-- SCOTT SCHEMA 사용하세요
USE SCOTT;
-- 문제 1: EMP 테이블에서 모든 직원을 급여(SAL)의 내림차순으로 정렬하여 조회하세요.
SELECT * FROM EMP
ORDER BY SAL DESC;

-- 문제 2: EMP 테이블에서 모든 직원을 입사 날짜(HIREDATE)의 오름차순으로 정렬하여 상위 5명의 직원 정보를 조회하세요.
SELECT * FROM EMP
ORDER BY HIREDATE LIMIT 5;

-- 문제 3: EMP 테이블에서 모든 직원을 이름(ENAME)으로 알파벳 순으로 정렬하고, 3번째부터 7번째 직원까지의 정보를 조회하세요.
SELECT * FROM EMP
ORDER BY ENAME LIMIT 5 OFFSET 3;

-- 문제 4: EMP 테이블에서 JOB이 'SALESMAN'인 직원들을 급여(SAL)의 오름차순으로 정렬하여 조회하세요.
SELECT * FROM EMP
WHERE JOB = 'SALESMAN' ORDER BY SAL;

-- 문제 5: EMP 테이블에서 가장 최근에 입사한 직원 3명의 ENAME, JOB, HIREDATE를 조회하세요.
SELECT ENAME, JOB, HIREDATE FROM EMP
ORDER BY HIREDATE DESC LIMIT 3;
