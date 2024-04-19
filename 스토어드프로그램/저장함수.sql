use store;

-- 스토어드 함수 생성 권한 허용
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION userFunc (value1 INT, value2 INT)
   RETURNS INT
BEGIN
   -- 함수 본문...
   RETURN value1 + value2;
END$$
DELIMITER ;

-- 저장 함수 사용하기
SELECT userFunc(10, 20);


-- 출생년도를 입력하고 나이가 출력되는 함수
DELIMITER $$
CREATE FUNCTION getAge(bYear INT)
	RETURNS INT
BEGIN
	DECLARE age INT;		-- 계산한 나이를 담을 변수 선언
    SET age = year( curdate() ) - bYear;	-- 현재 연도에서 출생연도 계산
	RETURN age;
END$$
DELIMITER ;

SELECT getAge(1990);

-- 내장함수 처럼 SQL문과 연결하여 사용 가능
SELECT name, getAge(birthYear) as 만나이 FROM usertbl;

-- 저장함수 확인하기
SHOW CREATE FUNCTION getAge;

-- 함수 삭제하기
DROP FUNCTION getAge;
