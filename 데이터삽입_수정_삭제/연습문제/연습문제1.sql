/*
### 연습문제 1: 새 직원 추가하기

문제: 다음 정보를 가진 새 직원을 `employees` 테이블에 추가하세요.

- 직원 번호: 500001 (또는 다음 사용 가능한 `emp_no`)
- 생년월일: "1990-01-01"
- 이름: "Jamie"
- 성: "Reyes"
- 성별: "F"
- 고용일: "2023-04-01"
*/
DESC employees;
SELECT * FROM employees;
INSERT INTO employees
VALUES (500001,'1990-01-01','Jamie','Reyes','F','2023-04-01');
/*
### 연습문제 2: 여러 직원 동시에 추가하기

문제: 다음 정보를 가진 여러 직원을 한 번의 `INSERT` 문으로 `employees` 테이블에 추가하세요.

1. 직원:
    - 직원 번호: 500002 (또는 다음 사용 가능한 `emp_no`)
    - 생년월일: "1985-02-15"
    - 이름: "Alex"
    - 성: "Smith"
    - 성별: "M"
    - 고용일: "2023-04-01"
2. 직원:
    - 직원 번호: 500003 (또는 다음 사용 가능한 `emp_no`)
    - 생년월일: "1978-07-22"
    - 이름: "Maria"
    - 성: "Garcia"
    - 성별: "F"
    - 고용일: "2023-04-02"
    
*/
INSERT INTO employees
VALUES (500002,'1985-02-15','Alex','Smith','M','2023-04-01'),
		(500003,'1978-07-22','Maria','Garcia','F','2023-04-02');
/*
LibraryManagement 스키마에서 데이터 삽입 연습
### 연습문제 1: `Books` 테이블에 새로운 도서 추가하기

문제: `Books` 테이블에 다음 정보를 가진 새로운 도서를 추가하세요.

- 제목: "The Little Prince"
- 저자: "Antoine de Saint-Exupéry"
- 출판 연도: 1943
- 장르: "Fiction"
*/
SHOW CREATE TABLE books;
desc books;
USE librarymanagement;
INSERT INTO LibraryManagement.books (title,author,PublishedYear,Genre)
VALUES ('The Little Prince','Antoine de Saint-Exupéry','1943','Fiction');
/*
### 연습문제 2: `Members` 테이블에 여러 회원 정보 동시에 추가하기

문제: `Members` 테이블에 다음 두 명의 회원 정보를 한 번의 `INSERT` 문으로 추가하세요.

1. 회원
    - 이름: "Alice"
    - 성: "Johnson"
    - 이메일: "alice.johnson@example.com"
    - 회원가입 날짜: 오늘 날짜
2. 회원
    - 이름: "Bob"
    - 성: "Smith"
    - 이메일: "bob.smith@example.com"
    - 회원가입 날짜: 오늘 날짜
*/
DESC LibraryManagement.members;
INSERT INTO LibraryManagement.members (FirstName,LastName,Email,MembershipDate)
VALUES ('Alice','Johnson','alice.johnson@example.com',now()),
		('Bob','Smith','bob.smith@example.com',now());
SELECT * FROM LibraryManagement.members;
/*
### 연습문제 3: `BorrowRecords` 테이블에 대출 기록 추가하기

문제: `BorrowRecords` 테이블에 다음 정보를 가진 대출 기록을 추가하세요. (이 작업을 수행하기 전에, `Members` 및 `Books` 테이블에 해당 회원과 도서가 이미 존재한다고 가정합니다.)

- 회원 ID: 1 
- 도서 ID: 1 
- 대출 날짜: "2023-03-01"
- 반납 예정 날짜: "2023-03-15"
*/
DESC LibraryManagement.BorrowRecords;
INSERT INTO LibraryManagement.BorrowRecords (MemberId, BookId, BorrowDate, ReturnDate)
VALUES (1,1,'2023-03-01','2023-03-15');
SELECT * FROM LibraryManagement.BorrowRecords;