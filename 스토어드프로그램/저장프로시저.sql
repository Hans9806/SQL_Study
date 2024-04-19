CREATE SCHEMA store;
USE store;

/* 스토어드 프로시저의 작성 */
-- 프로시저 내의 구분자(;)를 변경
DELIMITER $$

CREATE PROCEDURE userProc()
BEGIN    -- 프로시저 시작
   -- SQL 본문... (;)
   SELECT * FROM usertbl;
END$$       -- 프로시저 종료

-- 구분자를 원래대로 복원
DELIMITER ;

/* 스토어드 프로시저의 호출 */
CALL userProc();

-- 매개변수 사용하기
DELIMITER $$
CREATE PROCEDURE userProc1(IN userName VARCHAR(10))
BEGIN
	SELECT * FROM usertbl WHERE name = userName;
END$$
DELIMITER ;

CALL userProc1('김범수');
CALL userProc1('바비킴');

-- 매개변수 여러개 사용하기
DELIMITER $$
CREATE PROCEDURE userProc2(IN userBirth INT, IN userHeight INT)
BEGIN
	SELECT * FROM usertbl 
		WHERE birthYear > userBirth AND height > userHeight;
END$$
DELIMITER ;

CALL userProc2(1970, 175);

-- 출력 매개변수 사용하기
DROP PROCEDURE IF EXISTS userProc3;
DELIMITER $$
CREATE PROCEDURE userProc3(
	IN textValue CHAR(10),
    OUT outValue INT)
BEGIN
	INSERT INTO testtbl VALUES (null, textValue);
    SELECT max(id) INTO outValue FROM testTbl;
END$$
DELIMITER ;
-- 프로시저 작성 시점에는 테이블이 없어도 작성되지만 호출 시점에는 존재해야 한다.

CREATE TABLE testtbl (
	id INT PRIMARY KEY AUTO_INCREMENT,
    text char(255)
);

-- 첫번째 매개변수(IN)은 저장 프로시저의 INSERT문에 사용되고
-- 두번째 매개변수(OUT)은 해당 변수 (@val)에 SELECT문의 결과가 저장된다.
CALL userProc3('테스트', @val);

SELECT * FROM testtbl;
SELECT @val as '테스트테이블 아이디의 최대값';

-- INOUT : 입력된 값을 변경하여 호출 결과로 반환
DELIMITER $$
CREATE PROCEDURE swap(INOUT a INT, INOUT b int)
BEGIN
	SET @temp = a;
    SET a = b;
    SET b = @temp;
END$$
DELIMITER ;

SET @a = 7, @b = 5;
CALL swap(@a, @b);
SELECT @a, @b;

-- 조건문
DELIMITER $$
CREATE PROCEDURE ifelseProc(IN userName VARCHAR(10))
BEGIN
	DECLARE	bYear INT; 	-- 변수 선언 (저장 프로시저 내부에서 선언 및 사용)
    
    -- 쿼리문의 결과(생년)을 선언한 변수에 대입
    SELECT birthYear INTO bYear
    FROM usertbl WHERE name = userName;
    
    IF (bYear >= 1980) THEN
		SELECT '젊습니다';
	ELSE
		SELECT '중년입니다';
	END IF;
END$$
DELIMITER ;

CALL ifelseProc('이승기');

-- CASE문
DELIMITER $$
CREATE PROCEDURE caseProc( IN userName VARCHAR(10) )
BEGIN
	DECLARE bYear INT; 	 -- 생년을 저장하는 변수 선언
    DECLARE tti CHAR(3); -- 띠를 저장하는 변수
    
	SELECT birthYear INTO bYear			-- 쿼리 질의하여 생년을 대입
    FROM usertbl WHERE name = userName;
    
    CASE
		WHEN ( bYear % 12 = 0 ) THEN SET tti = '원숭이';
		WHEN ( bYear % 12 = 1 ) THEN SET tti = '닭';
		WHEN ( bYear % 12 = 2 ) THEN SET tti = '개';
		WHEN ( bYear % 12 = 3 ) THEN SET tti = '돼지';
		WHEN ( bYear % 12 = 4 ) THEN SET tti = '쥐';
		WHEN ( bYear % 12 = 5 ) THEN SET tti = '소';
		WHEN ( bYear % 12 = 6 ) THEN SET tti = '호랑이';
		WHEN ( bYear % 12 = 7 ) THEN SET tti = '토끼';
		WHEN ( bYear % 12 = 8 ) THEN SET tti = '용';
		WHEN ( bYear % 12 = 9 ) THEN SET tti = '뱀';
		WHEN ( bYear % 12 = 10 ) THEN SET tti = '말';
		WHEN ( bYear % 12 = 11 ) THEN SET tti = '양';
	END CASE;
    SELECT tti as 띠;
END$$
DELIMITER ;

CALL caseProc('김범수');

-- 반복문
-- WHILE문
DELIMITER $$
CREATE PROCEDURE printNumber()
BEGIN
	DECLARE counter INT DEFAULT 1;
    
    WHILE counter <= 5 DO
		SELECT counter;					-- 숫자 표시
        SET counter = counter + 1;		-- 1씩 증가하여 대입
	END WHILE;
END$$
DELIMITER ;

CALL printNumber();

-- 예외처리
-- DECLARE 액션[COUNTINUE|EXIT] HANDELER FOR 오류조건 처리할문장

SELECT * FROM notable;
-- 존재하지 않는 테이블 조회시 에러코드 1146번
-- Error Code: 1146. Table 'store.notable' doesn't exist

DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
	-- 1146번 코드를 만날 때 예외를 핸들링하고 계속 진행하는 예외처리
	DECLARE CONTINUE HANDLER FOR 1146 SELECT '테이블이 존재하지 않아요' as '오류메시지';
    SELECT * FROM notable;	-- 예외발생하는 문장
END$$
DELIMITER ;

CALL errorProc();

-- 프로시저 목록 표시하기
SHOW PROCEDURE STATUS;
SHOW PROCEDURE STATUS WHERE DB LIKE 'store'; 

-- 프로시저 정의 확인하기
SHOW CREATE PROCEDURE userProc;


