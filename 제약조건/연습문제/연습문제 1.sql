/*

**`LibraryManagement`** 데이터베이스는 도서관 관리 시스템을 위한 데이터베이스입니다. 이 시스템은 도서(Books), 회원(Members), 대출 기록(BorrowRecords) 등 주요 정보를 관리합니다.
*/
CREATE SCHEMA LibraryManagement;
/*
1. **Books 테이블**: 도서 정보를 저장합니다.
    - **`BookID`** (정수형, 기본 키, 자동 증가): 도서의 고유 번호입니다.
    - **`Title`** (문자열, 필수): 도서의 제목입니다.
    - **`Author`** (문자열, 필수): 도서의 저자입니다.
    - **`PublishedYear`** (정수형): 도서의 출판 연도입니다.
    - **`Genre`** (문자열): 도서의 장르입니다.
    - **`PublishedYear`**는 1500 이상의 값을 가져야 하며, **`Genre`**는 NULL을 허용하지 않습니다.
    */
    CREATE TABLE Books (
		BookID INT PRIMARY KEY AUTO_INCREMENT,
        Title VARCHAR(255) NOT NULL,
        Author VARCHAR(255) NOT NULL,
        PublishedYear INT CHECK (PublishedYear >= 1500),
        Genre VARCHAR(255)
    );
    DESCRIBE Books;
    SELECT * FROM Books;
    /*
2. **Members 테이블**: 도서관 회원 정보를 저장합니다.
    - **`MemberID`** (정수형, 기본 키, 자동 증가): 회원의 고유 번호입니다.
    - **`FirstName`** (문자열, 필수): 회원의 이름입니다.
    - **`LastName`** (문자열, 필수): 회원의 성입니다.
    - **`Email`** (문자열, 필수, 고유): 회원의 이메일 주소입니다.
    - **`MembershipDate`** (날짜, 기본값 현재 날짜): 회원가입 날짜입니다.
    - **`Email`** 열에는 고유 제약조건을 추가하고, **`FirstName`** 및 **`LastName`** 열은 빈 문자열을 허용하지 않아야 합니다.
    */
    CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    MembershipDate DATE DEFAULT (CURRENT_DATE),
    CHECK (FirstName != ''),
    CHECK (LastName != '')
    );
    DESCRIBE Members;
    SELECT * FROM Members;
    /*
3. **BorrowRecords 테이블**: 도서 대출 기록을 저장합니다.
    - **`RecordID`** (정수형, 기본 키, 자동 증가): 대출 기록의 고유 번호입니다.
    - **`MemberID`** (정수형, 외래 키): 대출한 회원의 ID입니다.
    - **`BookID`** (정수형, 외래 키): 대출된 도서의 ID입니다.
    - **`BorrowDate`** (날짜): 도서 대출 날짜입니다.
    - **`ReturnDate`** (날짜): 도서 반납 예정 날짜입니다.
    - 레퍼런스 옵션으로 **`ON DELETE CASCADE`**와 **`ON UPDATE NO ACTION`**을 설정해야 합니다.
    */
    CREATE TABLE BorrowRecords(
		RecordID INT PRIMARY KEY AUTO_INCREMENT,
        MemberID INT NOT NULL,
        BookID INT NOT NULL,
        BorrowDate DATE, 
        ReturnDate DATE,
        FOREIGN KEY (MemberID) REFERENCES members(MemberID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
        FOREIGN KEY (BookID) REFERENCES books(BookID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
    );
    DESCRIBE BorrowRecords;
	SELECT * FROM BorrowRecords;
    /*

### **연습문제**

**문제 1:** **`Books`** 테이블을 생성하세요.
CREATE 
- **`PublishedYear`**는 1500 이상의 값을 가져야 하며, **`Genre`**는 NULL을 허용하지 않습니다.

**문제 2:** **`Members`** 테이블을 생성하세요.

- **`Email`** 열에는 고유 제약조건을 추가하고, **`FirstName`** 및 **`LastName`** 열은 빈 문자열을 허용하지 않아야 합니다.

**문제 3:** **`BorrowRecords`** 테이블을 생성하세요. 이 테이블은 **`Members`**와 **`Books`** 테이블에 대한 외래 키 제약 조건을 포함해야 합니다.

- 레퍼런스 옵션으로 **`ON DELETE CASCADE`**와 **`ON UPDATE NO ACTION`**을 설정해야 합니다.