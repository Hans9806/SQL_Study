-- 트리거
use store;

-- usertbl 테이블의 데이터에 변경이 일어나면
-- backup 테이블에 자동으로 작동하는 트리거를 생성
SELECT * FROM usertbl;

DROP TABLE IF EXISTS `backup_usertbl`;
CREATE TABLE `backup_usertbl` (
  `userID` char(8) NOT NULL,
  `name` varchar(10) NOT NULL,
  `birthYear` int NOT NULL,
  `addr` char(2) NOT NULL,
  `mobile1` char(3) DEFAULT NULL,
  `mobile2` char(8) DEFAULT NULL,
  `height` smallint DEFAULT NULL,
  `mDate` date DEFAULT NULL,
  modtype	CHAR(2),		-- 데이터 변경 타입
  modDate	DATE,			-- 데이터 변경 날짜
  modUser	VARCHAR(255)	-- 데이터 변경 사용자
);

DELIMITER $$
CREATE TRIGGER updateTrg
	AFTER UPDATE		-- 업데이트 작업이 일어난 이후
    ON userTbl			-- 해당 테이블에서 데이터가 변경되면
    FOR EACH ROW	    -- 각 행마다 적용
BEGIN
	-- 백업 테이블에 수정 이전 정보를 추가하라.
    INSERT INTO `store`.`backup_usertbl`
VALUES
	(OLD.userID, OLD.name, OLD.birthYear, OLD.addr, 
	OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
	'수정', curdate(), current_user() );
END$$
DELIMITER ;

-- UPDATE문이 수행된 후 트리거 작동
UPDATE usertbl SET addr = '제주' WHERE userID = 'EJW';
UPDATE usertbl SET mobile2 = '2222222' WHERE userID = 'BBK';

-- 업데이트문이 수행될 때마다 트리거는 자동으로 각 줄에 수행이 됨.
SELECT * from usertbl;
SELECT * from backup_usertbl;

-- 삭제 트리거 생성
DROP TRIGGER if exists deleteTrg;
DELIMITER $$
CREATE TRIGGER deleteTrg
	AFTER DELETE		-- 삭제 작업이 일어난 이후
    ON userTbl			-- 해당 테이블에서 삭제되면
    FOR EACH ROW	    -- 각 행마다 적용
BEGIN
	-- 백업 테이블에 수정 이전 정보를 추가하라.
    INSERT INTO `store`.`backup_usertbl`
VALUES
	(OLD.userID, OLD.name, OLD.birthYear, OLD.addr, 
	OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
	'삭제', curdate(), current_user() );
END$$
DELIMITER ;

DROP TABLE buytbl;		-- userid의 참조무결성 제거을 위해 삭제
DELETE FROM usertbl WHERE height < 175;

SELECT * FROM usertbl;
SELECT * FROM backup_usertbl;

-- 트리거 목록 확인하기
SHOW TRIGGERS FROM store;