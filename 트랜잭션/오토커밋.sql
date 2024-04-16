use tcl;

-- actocommit 활성화 여부 확인
SHOW VARIABLES LIKE 'actocommit';

-- OFF 비활성화 (0)
SET autocommit = 0;
-- ON 활성화 (1)
SET autocommit = 1;

CREATE TABLE person (
	name VARCHAR(25),
    age INT
);

INSERT INTO person (name, age) 
	VALUES ('홍길동',30);

SELECT * FROM person;

-- 오토커밋 비활성화
SET autocommit = 0;

INSERT INTO person VALUES ('임꺽정', 40);

SELECT * FROM person;
-- 변경사항을 반영 (트랜잭션 제어)
COMMIT;

-- 이전 커밋 단위부터 작업 단위(트랜잭션)으로 끊어짐
INSERT INTO person VALUES ('전우치',25);
SELECT * FROM person;
ROLLBACK;
SELECT * FROM person;

-- 이전 커밋으로부터 작업단위가 나누어짐 (트랜잭션)
INSERT INTO person VALUES ('김철수',20);
INSERT INTO person VALUES ('마이콜',25);
COMMIT;

-- 오토커밋 재활성화
SET autocommit = 1;
SHOW VARIABLES LIKE 'autocommit';
