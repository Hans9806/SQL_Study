-- 문제 1: 'report_user'라는 사용자를 생성하고,
-- 'sakila' 데이터베이스에 대한 SELECT 권한만 부여하세요.
--  이 사용자는 보고서 작성을 위해 데이터를 읽을 수 있어야 합니다.
CREATE USER 'report_user'@'%' IDENTIFIED BY '1234'; 
GRANT SELECT ON sakila.* TO 'report_user'@'%';

-- 문제 2: 'admin_user'라는 사용자를 생성하고, 
-- 'world' 데이터베이스에 대해 모든 권한을 부여하세요.
--  이 사용자는 데이터베이스 관리자 역할을 수행합니다.
CREATE USER 'admin_user'@'%' IDENTIFIED BY '4567'; 
GRANT ALL PRIVILEGES ON world.* TO 'admin_user'@'%';

-- 문제 3: 'dev_user'라는 사용자를 생성하고,
-- 사용자에게 'sakila' 데이터베이스의 'actor' 테이블에 대한
-- SELECT, INSERT, UPDATE 권한을 부여하세요.
-- 이 사용자는 개발자 역할을 수행하며, 'actor' 테이블의 데이터를 조회하고 수정할 수 있어야 합니다.
CREATE USER 'dev_user'@'%' IDENTIFIED BY '1234'; 
GRANT SELECT, INSERT, UPDATE ON sakila.actor TO 'dev_user'@'%';

-- 문제 4: 'guest_user'라는 사용자를 생성하고,
-- 'world' 데이터베이스의 'city' 테이블에 대한 SELECT 권한을 부여하세요. 
-- 이 사용자는 손님 역할을 수행하며, 'city' 테이블에서 데이터를 조회할 수만 있어야 합니다.
CREATE USER 'guest_user'@'%' IDENTIFIED BY '1234'; 
GRANT SELECT ON world.city TO 'guest_user'@'%';

-- 문제 5: 'report_user' 사용자로부터 'sakila' 데이터베이스에
-- 대한 SELECT 권한을 회수하세요.
-- 이 사용자는 더 이상 보고서 작성 역할을 수행하지 않습니다.
REVOKE SELECT ON sakila.* FROM 'report_user'@'%';

-- 문제 6: 'dev_user' 사용자에게 부여된 'sakila' 데이터베이스의
-- 'actor' 테이블에 대한 모든 권한을 회수하고, 
-- 대신 SELECT 권한만 다시 부여하세요.
REVOKE ALL ON sakila.actor FROM 'dev_user'@'%';
GRANT SELECT ON sakila.actor TO 'dev_user'@'%';

-- 연습문제에서 작성한 user 삭제
DROP USER 'report_user'@'%';
DROP USER 'admin_user'@'%';
DROP USER 'dev_user'@'%';
DROP USER 'guest_user'@'%';