-- 커서
USE store;

-- 테이블의 키 속성을 가져와서 키의 평균을 구하는 프로시저
-- 커서를 통해 
DELIMITER $$
CREATE PROCEDURE cursurProc()
BEGIN
	DECLARE userHeight INT;				-- 키 변수 선언
	DECLARE cnt INT DEFAULT 0;  		-- 고객 수(= 읽은 행의 수)
    DECLARE totalHeight INT DEFAULT 0; 	-- 키 합계
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; 	-- 행이 끝났는지 여부
    
    -- 1. 커서 선언
    DECLARE userCursor CURSOR FOR 
		SELECT height FROM usertbl;		-- 테이블에서 키를 가져온 행들의 커서
        
	-- 2. 반복 조건 선언
    DECLARE CONTINUE HANDLER FOR
		NOT FOUND SET endOfRow = TRUE;

	-- 3. 커서 열기
    OPEN userCursor;
    
    cursorLoop : LOOP	-- 반복 구간 (반복 이름 지정)
    -- 4. 커서에서 데이터 가져오기
		FETCH userCursor INTO userHeight;
        -- 커서에 있는 데이터를 userHeight 변수에 대입
        
        IF endOfRow THEN		-- 만약 끝행(true)이면
			LEAVE cursorLoop;	-- 루프를 종료해라.
		END IF;
        
        -- 5. 데이터 처리
        SET cnt = cnt + 1;		-- 읽을 행의 수를 증가시키고
        SET totalHeight = totalHeight + userHeight;	-- 읽은 값을 합계에 더함
	END LOOP cursorLoop;  -- 반복 종료
	
    -- 6. 커서 닫기
    CLOSE userCursor;
    
    SELECT totalHeight / cnt as `고객 키의 평균`;
END$$

DELIMITER ;

-- 프로시저 실행
CALL cursurProc();