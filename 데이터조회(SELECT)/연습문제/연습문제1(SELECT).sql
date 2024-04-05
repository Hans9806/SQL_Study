-- 문제 1: EMP 테이블에서 모든 정보를 조회하세요.
SELECT * FROM EMP;
-- 문제 2: EMP 테이블에서 직원의 이름(ENAME)과 급여(SAL)만 조회하세요.
SELECT ENAME, SAL
FROM EMP;
-- 문제 3: EMP 테이블에서 급여(SAL)가 3000 이상인 직원의 ENAME, JOB, SAL을 조회하세요.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL >= 3000;
-- 문제 4: EMP 테이블에서 직원의 이름(ENAME)이 'S'로 시작하는 직원의 모든 정보를 조회하세요.
SELECT *
FROM EMP
WHERE ENAME LIKE 'S%';
-- 문제 5: EMP 테이블에서 직원의 JOB이 'CLERK', 'MANAGER', 'ANALYST' 중 하나에 해당하는 직원의 ENAME, JOB을 조회하세요.
SELECT ENAME, JOB
FROM EMP
WHERE JOB = 'CLERK' OR JOB = 'MANAGER' OR JOB = 'ANALYST';
-- 문제 6: EMP 테이블에서 직원의 MGR이 NULL이 아닌 모든 직원의 ENAME, MGR을 조회하세요.
SELECT ENAME, MGR
FROM EMP
WHERE MGR IS NOT NULL;
-- 문제 7: EMP 테이블에서 HIREDATE가 '1981-01-01'부터 '1983-12-31' 사이인 직원의 ENAME, HIREDATE를 조회하세요.
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN '1981-01-01' AND '1983-12-31';