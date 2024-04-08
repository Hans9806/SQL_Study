-- 집계 함수
USE scott;

SELECT * FROM emp;

-- 집계함수의 결과는 단일행, 
-- 관심있는 attribute에 주로 사용
-- null 값들은 제외하고 요약 값을 추출

-- count : 주어진 조건을 만족하는 행의 개수를 반환
SELECT count(*) FROM emp;		-- 직원 수
SELECT count(ename) FROM emp;	-- 직원이름의 수
-- 행의 값이 null 인 경우는 제외
SELECT count(mgr) FROM emp;		-- 매니저의 수 (매니저가 없는 경우 제외)
SELECT count(comm) FROM emp;    -- 커미션의 수 (커미션 없는 경우 제외)

-- sum : 숫자로 이루어진 열(속성, 애트리뷰트)의 총합을 계산
SELECT sum(sal) FROM emp;
SELECT sum(comm) FROM emp;	-- 관심있는 열에 null 값이 포함될 경우 제외하고 요약

-- avg : 숫자로 이루어진 열(속성, 애트리뷰트)의 평균을 계산 -> 소수로 리턴
SELECT avg(sal) FROM emp;
-- round 함수와 같이 사용하면 반올림 round(소수숫자, 자리수)
SELECT round(avg(sal)) FROM emp;		-- 0의 자리 반올림
SELECT round(avg(sal), 2) FROM emp; 	-- 소수점 2자리에서 반올림
SELECT round(avg(sal), -2) FROM emp;	-- 십의 자리에서 반올림

-- min, max : 열에서 최대값 최소값을 찾음
SELECT min(sal), max(sal) FROM emp;
SELECT min(sal) as 최소급여, max(sal) as 최대급여 FROM emp;
-- min, max는 숫자 이외의 다양한 데이터 형식에도 사용 가능
SELECT min(ename), max(ename) FROM emp;
SELECT min(hiredate), max(hiredate) FROM emp;

-- stddev 표준편차, var_samp 분산
SELECT stddev(sal), var_samp(sal) FROM emp;

-- GROUP BY : 특정 컬럼의 값에 따라 행들을 그룹화
  -- ```sql
--   SELECT 컬럼명1, 집계함수(컬럼명2)
--   FROM 테이블명
--   GROUP BY 컬럼명1
--   ```
--    - 컬럼명1 : 그룹화를 할 기준이되는 열
--    - 컬럼명2 : 그룹에 적용할 집계함수의 대상이 되는 열
-- 주의사항 : GROUP BY 절에 지정된 열 외의 다른 열을 SELECT 절에 포함시킬 수 없음.

select * from emp;
-- Job 별로 평균 급여를 계산
SELECT 
    job, avg(sal)
FROM
    emp
GROUP BY job;
-- 별칭 부여
SELECT 
    job as 직무, avg(sal) as 평균급여
FROM
    emp
GROUP BY job;

-- Job 별, 부서별로 평균 급여를 계산
SELECT 
    job, deptno, avg(sal)
FROM
    emp
GROUP BY job, deptno;

-- GROUP BY 절의 순서
-- WHERE 절 다음 ORDER BY 절 이전에 위치해야 함.
-- 부서별 평균급여를 평균급여 높은 순으로 조회
SELECT deptno, avg(sal) as 평균급여
FROM emp
GROUP BY deptno
ORDER BY 평균급여 DESC;

-- HAVING 절
-- GROUP BY 로 인해 생성된 그룹에 조건을 적용할 때 사용
-- WHERE 절과의 차이점 
  -- WHERE절 : 테이블의 각 개별행에 대해 조건을 정의
  -- HAVING절 : 그룹화된 결과에 대해 조건을 정의
  
-- 평균 급여가 2000 이상인 부서의 급여 조회
SELECT deptno, avg(sal) as 평균급여
FROM emp
-- WHERE sal > 1500 -- 원 테이블의 각 행에 대하여 조건
GROUP BY deptno
HAVING 평균급여 >= 2000;	-- 그룹화된 결과에 대해 조건

-- WEHRE, GROUPBY, HAVING 절은 순서가 바뀔 수 없다.

-- WITH ROLLUP
-- 각 그룹별 소합계 및 총합계를 위한
-- 요약 보고서 작성이나 데이터분석에 사용
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY deptno, job WITH ROLLUP;