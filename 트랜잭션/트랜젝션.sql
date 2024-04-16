-- 트랜잭션
DROP SCHEMA IF EXISTS tcl;
CREATE SCHEMA tcl;
use tcl;

-- 초기 테이블 생성 (계좌)
CREATE TABLE accounts (
	account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    balance BIGINT NOT NULL DEFAULT 0
);

-- 로그 테이블 생성
CREATE TABLE transaction_log (
	transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    from_account INT,		-- 보낸 계좌 ID
    to_account INT,			-- 받은 계좌 ID
    amount BIGINT,			-- 보낸 금액량
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,	-- 보낸시간 (기본값 현재)
    FOREIGN KEY (from_account) REFERENCES accounts(account_id),
    FOREIGN KEY (to_account) REFERENCES accounts(account_id)
);

DESC accounts;
DESC transaction_log;

-- 계정 데이터 삽입
INSERT INTO accounts (account_name, balance)
	VALUES ('홍길동', 100000), ('전우치',200000);

SELECT * FROM accounts;

-- 계좌 거래 트랜잭션(작업단위) 예시
START TRANSACTION;		-- 트랜잭션 시작

-- 1. 인출 (홍길동 계좌에서 15만원 인출)
UPDATE accounts SET balance = balance -50000
WHERE account_name = '홍길동';

SELECT * FROM accounts;		-- 세션1(현재 세션)에서 조회 (부분 완료)
-- 2. 입금 (전우치 계좌로 15만원 입금)
UPDATE accounts SET balance = balance + 50000
WHERE account_name = '전우치';

-- 3. 거래 기록 저장
INSERT INTO transaction_log (from_account, to_account, amount)
	VALUES (
		(SELECT account_id FROM accounts WHERE account_name = '홍길동'),	-- 보낸 사람 ID
        (SELECT account_id FROM accounts WHERE account_name = '전우치'),	-- 받은 사람 ID
        50000 );			-- 금액
SELECT * FROM transaction_log;		-- 거래기록 부분 완료

-- 모든 변경사항을 확정
COMMIT;

SELECT * FROM accounts;
SELECT * FROM transaction_log;

-- ROLLBACK 예시
START TRANSACTION;

-- 1. 인출 (홍길동 계좌에서 15만원 인출)
UPDATE accounts
	SET balance = balance - 150000 
	WHERE account_name = '홍길동';

-- 2. 입금 (전우치 계좌로 15만원 입금)
UPDATE accounts 
	SET balance = balance + 150000 
	WHERE account_name = '전우치';

SELECT * FROM accounts;  -- 데이터 확인

-- 데이터 확인 시 문제 발생, 변경사항을 취소
ROLLBACK;

-- 트랜잭션 시작 이전(최종 커밋 상태)으로 데이터가 취소
SELECT * FROM accounts;	  -- 데이터 확인

-- SAVEPOINT 예시

START TRANSACTION;

-- 첫번째 거래
-- 1. 인출 (홍길동 계좌에서 3만원 인출)
UPDATE accounts
	SET balance = balance - 30000 
	WHERE account_name = '홍길동';

-- 2. 입금 (전우치 계좌로 3만원 입금)
UPDATE accounts 
	SET balance = balance + 30000 
	WHERE account_name = '전우치';

-- 3. 거래 기록 저장
INSERT INTO transaction_log (from_account, to_account, amount)
	VALUES (
		(SELECT account_id FROM accounts WHERE account_name = '홍길동'), -- 보낸사람ID
        (SELECT account_id FROM accounts WHERE account_name = '전우치'), -- 받은사람ID
        30000 );		-- 금액
        
SELECT * FROM accounts;
SELECT * FROM transaction_log;

SAVEPOINT midway;	-- 첫번째 거래(입출금) 기록저장 및 중간점 설정

-- 두번째 거래
-- 1. 인출 (홍길동 계좌에서 10만원 인출)
UPDATE accounts
	SET balance = balance - 100000 
	WHERE account_name = '홍길동';

-- 2. 입금 (전우치 계좌로 10만원 입금)
UPDATE accounts 
	SET balance = balance + 10000 
	WHERE account_name = '전우치';

SELECT * FROM accounts;		-- 금액이 마이너스 데이터 확인

-- 세이브포인트(중간점)까지 롤백
ROLLBACK TO midway;

-- ROLLBACK; -- 일반 롤백을 하게 될 경우, 시작지점으로 복구됨

SELECT * FROM accounts;		-- 첫번째 거래내역까지 롤백

-- 첫번째 거래내역(중간점)까지 확정 (두번째 거래내역은 반영안됨)
COMMIT;