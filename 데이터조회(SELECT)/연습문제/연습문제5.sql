-- 그룹화 연습문제 (scott 스키마)
-- 문제 1: EMP 테이블에서 전체 직원 수를 계산하세요.
SELECT * FROM EMP;
SELECT count(*) FROM emp;
-- 문제 2: EMP 테이블에서 각 부서(DEPTNO)별 직원 수를 계산하세요.
SELECT deptno as 부서, count(deptno) FROM emp
GROUP BY deptno;
-- 문제 3: EMP 테이블에서 전체 직원의 평균 급여(SAL)를 계산하세요.
SELECT round(avg(sal), -1) as 평균급여 
FROM emp;
-- 문제 4: EMP 테이블에서 각 직무(JOB)별 평균 급여를 계산하되, 평균 급여가 2000 이상인 직무만 포함하세요.
SELECT job, avg(sal) as 평균급여
FROM emp
GROUP BY job
HAVING 평균급여 >= 2000;
-- 문제 5: EMP 테이블에서 가장 높은 급여와 가장 낮은 급여를 조회하세요.
SELECT min(sal), max(sal) FROM emp;
-- 문제 6: EMP 테이블에서 각 부서별로 가장 높은 급여를 받는 직원의 급여를 조회하세요.
SELECT deptno, max(sal) as 최고급여
FROM emp
GROUP BY deptno;
-- 문제 7: EMP 테이블에서 각 부서별 총 급여(SAL)를 계산하세요.
SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno;