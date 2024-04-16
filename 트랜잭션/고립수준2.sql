
-- 세션2 : 쓰기 트랜잭션
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

USE tcl;

UPDATE person SET age = 50 WHERE name = '홍길동';

ROLLBACK;	-- 커밋하지 않은 내용 초기화

SELECT * FROM person;

/* 2. READ COMMITTED, 반복 불가능 읽기 */

START TRANSACTION;

-- 1. 쓰기
UPDATE person 
	SET age = 50
	WHERE name = '홍길동';

-- 2. 커밋
COMMIT;

/* 3. REPEATABLE READ, 반복 가능 읽기 */
START TRANSACTION;

-- 1. 쓰기
UPDATE person 
	SET age = 50
	WHERE name = '홍길동';

-- 2. 커밋
COMMIT;


/* 4. SERIALIZABLE */
START TRANSACTION;

SELECT * FROM person;

-- 1. 쓰기 => 쓰기 불가
-- 해당 트랜잭션의 수정이 배타 LOCK 설정한 효과
UPDATE person 
	SET age = 70
	WHERE name = '홍길동';

COMMIT;

