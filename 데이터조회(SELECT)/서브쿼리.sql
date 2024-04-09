-- 서브쿼리
USE scott;

-- 특정 직원 'ALLEN'보다 급여를 많이 받는 직원 찾기
select ename, sal from emp;

-- 서브쿼리 => 결과 (1600)을 확인 후
select sal from emp where ename = 'ALLEN'; 
-- 메인쿼리 => 비교조건으로 하드코딩
select ename, sal from emp where sal > 1600;

-- 메인 쿼리의 WHERE 절 조건에 서브쿼리를 삽입 : 동적으로 조건이 설정 가능
SELECT ename, sal
FROM emp
WHERE sal > (select sal from emp where ename = 'ALLEN');
    
-- 단일 행(single row) 서브쿼리
-- 서브쿼리의 결과가 반드시 하나의 행만 반환해야 함.

-- 특정 부서(30)의 평균급여보다 높은 급여를 받는 직원 조회

-- 집계함수를 사용하여 결과값이 단일행, -> 서브쿼리로 사용
select avg(sal) from emp where deptno = 30;
-- 서브쿼리의 결과값을 where절의 조건으로 받는 메인쿼리
select ename, sal from emp where sal > 1566.6667;

-- 메인 쿼리와 서브 쿼리를 하나의 쿼리로 사용.
select ename, sal from emp 
where sal > (select avg(sal) from emp where deptno = 30);

-- IN 함수 : 목록 안에 값이 포함되었는지 확인
SELECT * FROM emp WHERE deptno IN(10, 20, 30);

-- 메인쿼리
SELECT e.empno, e.ename, e.sal, d.dname, d.loc
FROM emp e JOIN dept d on e.deptno = d.deptno
WHERE e.empno IN(SELECT empno from emp where sal > 2000);

-- 서브쿼리
SELECT empno from emp where sal > 2000;	-- 2000보다 급여를 많이 받는 6명(행) 조회 결과

-- 서브쿼리 결과 20, 30
SELECT deptno from dept where dname = 'sales' or dname = 'research';

-- 메인쿼리 IN ( 20, 30의 결과에 해당하는 서브쿼리 )
SELECT * FROM emp 
WHERE deptno IN(SELECT deptno from dept where dname = 'sales' or dname = 'research');

-- 아래 실행문과 동일한 결과를 갖는다.
SELECT * FROM emp 
WHERE deptno IN(20, 30);



-- ANY 함수
SELECT sal FROM emp WHERE deptno = 20; -- 서브쿼리의 결과
 -- 20번 부서 직원의 급여 (5행) (800, 2975, 3000, 1100, 3000)

-- 메인 쿼리의 any 함수에 사용 (비교연산자와 함께 사용)
-- 하나라도 큰 것이 있으면 참 => 800보다 많이 받는 모든 직원
SELECT ename, sal FROM emp 
WHERE sal > ANY(SELECT sal FROM emp WHERE deptno = 20);

-- ALL 함수
-- (800, 2975, 3000, 1100, 3000) 여러 행의 결과 값 모두보다 이상이여야 참
-- 3000(최대값)보다 큰 경우만 참
SELECT ename, sal FROM emp 
WHERE sal >= ALL(SELECT sal FROM emp WHERE deptno = 20);

-- 800(최소값)보다 작은 경우만 참
SELECT ename, sal FROM emp 
WHERE sal <= ALL(SELECT sal FROM emp WHERE deptno = 20);

-- EXISTS : 주로 상호 연관 서브쿼리에서 유용하게 사용
-- 상호연관 쿼리 : 메인 쿼리의 칼럼을 서브쿼리에서 사용하는 것
-- 각 부서에 대해 직원이 존재하는 경우 참, 존재하지 않으면 거짓
SELECT dname, loc FROM dept d
WHERE EXISTS( SELECT 1 FROM emp e WHERE e.deptno = d.deptno );

 -- SELECT 절에서 서브쿼리 사용
 SELECT ename, sal, (서브쿼리) FROM emp;
 -- 서브쿼리
 SELECT e.ename,
		e.sal,
		e.deptno,
        -- 각 부서의 평군급여 => 메인쿼리의 컬럼의 하나로 사용
		(SELECT avg(sal) FROM emp WHERE deptno = e.deptno) AS "부서평균급여"
FROM emp e;
-- 단일 행을 반환하여 사용
-- 데이터베이스에 따라 성능 및 비용 문제가 발생할 수 있음. 데이터 양이 많을 경우 다른 방법을 사용
-- 쿼리의 결과를 유연하게 동적으로 표현하고 싶을 때 사용

-- FROM절 : 인라인 뷰(Inline View)
-- 서브쿼리가 임시 테이블처럼 동작하게 하여 메인 쿼리에 사용
-- 생성된 임시 테이블은 쿼리 실행시점에만 존재하고 사라짐. => 쿼리문 안에서만 사용
-- FROM 절의 임시 테이블은 약칭을 주어 사용해야 한다.

-- 부서별 급여평균
SELECT deptno, avg(sal) FROM emp GROUP BY deptno;

SELECT dept_avg.deptno, dept_avg.avg_sal
FROM ( SELECT deptno, avg(sal) as avg_sal FROM emp GROUP BY deptno ) as dept_avg;