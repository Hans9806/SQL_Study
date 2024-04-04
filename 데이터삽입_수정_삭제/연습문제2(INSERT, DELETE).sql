-- 데이터 삽입, 추가, 삭제 연습문제 
-- LibraryManagement 스키마에서 진행해주세요.
USE LibraryManagement;
-- 문제 1: 'Books' 테이블에 새로운 도서 추가하기
-- 제목: "Learning SQL", 저자: "Alan Beaulieu", 출판 연도: 2020, 장르: "Educational"
DESC books;
SELECT * FROM books;
INSERT INTO books (Title, Author, PublishedYear, Genre)
VALUES ('Learning SQL','Alan Beaulieu',2020,'Educational');

-- 문제 2: 'Members' 테이블에 새로운 회원 추가하기
-- 이름: "Lucy", 성: "Heartfilia", 이메일: "lucy.heart@example.com", 회원가입 날짜: 오늘 날짜
DESC members;
SELECT * FROM members;
INSERT INTO members (FirstName, LastName, Email, MembershipDate)
VALUES ('Lucy','Heartfilia','lucy.heart@example.com',NOW());

-- 문제 3: 'BorrowRecords' 테이블에 대출 기록 추가하기
-- 회원 ID: 1, 도서 ID: 1, 대출 날짜: "2023-03-15", 반납 예정 날짜: "2023-04-14"
DESC BorrowRecords;
SELECT * FROM BorrowRecords;
INSERT INTO BorrowRecords (MemberID, BookID, BorrowDate, ReturnDate)
VALUES (1,1,'2023-03-15','2023-04-14');

-- 문제 4: 'Books' 테이블에서 제목이 "Learning SQL"인 도서의 장르를 "Technical"로 변경하기
DESC books;
SELECT * FROM books;
UPDATE books
SET Title = 'Technical'
WHERE Title = 'Learning SQL';

-- 문제 5: 'Members' 테이블에서 회원 ID가 1인 회원의 이메일 주소를 "lucy.h@example.com"으로 변경하기
DESC members;
SELECT * FROM members;
UPDATE members
SET email = 'lucy.h@example.com'
WHERE MemberID = 1;

-- 문제 6: 'BorrowRecords' 테이블에서 회원 ID가 1이고 도서 ID가 1인 대출 기록의 반납 예정 날짜를 "2023-04-30"으로 변경하기
DESC BorrowRecords;
SELECT * FROM BorrowRecords;
UPDATE BorrowRecords
SET returndate = '2023-04-30'
WHERE memberID = 1 AND bookID = 1;

-- 문제 7: 'Books' 테이블에서 출판 연도가 2020년인 모든 도서의 출판 연도를 2021로 변경하기
DESC books;
SELECT * FROM books;
UPDATE books
SET PublishedYear = 2021
WHERE PublishedYear = 2020;

-- 문제 8: 'Members' 테이블에서 이메일 주소가 "lucy.h@example.com"인 회원을 삭제하기
DESC members;
SELECT * FROM members;
DELETE FROM members
WHERE email = 'lucy.h@example.com';

-- 문제 9: 'BorrowRecords' 테이블에서 반납 예정 날짜가 "2023-04-30"인 모든 대출 기록을 삭제하기
DESC BorrowRecords;
SELECT * FROM BorrowRecords;
DELETE FROM BorrowRecords
WHERE returndate = '2023-04-30';