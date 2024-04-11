-- 내장함수 연습
-- scott DB를 사용하세요.
USE scott;
-- 문제 1: EMP 테이블에서 모든 직원의 ENAME을 대문자로 변환하여 조회하세요.
SELECT upper(ename)
FROM emp;
-- 문제 2: EMP 테이블에서 모든 직원의 입사 연도(HIREDATE)만 추출하여 조회하세요.
SELECT year(hiredate)
FROM emp;
-- 문제 3: EMP 테이블에서 각 직원의 이름(ENAME)과 '1981-12-01'부터 각 직원의 입사일까지 몇 일이 지났는지 계산하여 조회하세요.
SELECT ename, datediff('1981-12-01', hiredate)
FROM emp;
-- 문제 4: EMP 테이블에서 모든 직원의 이름(ENAME)에 "님"을 붙여서 조회하세요.
SELECT concat(ename,'님')
FROM emp;
-- 문제 5: EMP 테이블에서 가장 높은 SAL을 가진 직원의 SAL을 조회하세요. 
SELECT ename, sal 
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);
-- 문제 6: EMP 테이블에서 직원의 이름과 COMM 이 null인 사람을 "커미션 없음"이라는 컬럼으로 나타내어 조회하세요. 
SELECT ename, ifnull(COMM, '커미션 없음') AS '커미션'
FROM emp;