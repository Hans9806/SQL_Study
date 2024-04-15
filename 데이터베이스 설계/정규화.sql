-- 1 정규형 (1NF)
use nomarlization;

-- 비정규화 학생 테이블
CREATE TABLE Students (
	StudentId INT PRIMARY KEY,	-- 학번
    Name VARCHAR(50),			-- 이름
    Courses VARCHAR(255)		-- 과정들
);

INSERT INTO students VALUES
	(1, '홍길동', '수학, 과학'),
    (2, '임꺽정', '국어'),
    (3, '전우치', '사회, 국어, 영어');
-- 릴레이션의 속성값은 반드시 원자값이어야 한다 => 1정규화에 위배

SELECT * FROM students;

DROP TABLE IF EXISTS Students_1NF;
CREATE TABLE Students_1NF (
	StudentCourseId INT PRIMARY KEY AUTO_INCREMENT,-- 기본키
	StudentId INT,				    -- 학번
    Name VARCHAR(50),		     	-- 이름
    Course VARCHAR(255)			    -- 과정
);

-- 1정규화를 적용을 위해 데이터를 원자값으로 쪼개어 삽입
INSERT INTO Students_1NF (StudentId, Name, Course) VALUES
	(1, '홍길동', '수학'),
    (1, '홍길동', '과학');
INSERT INTO Students_1NF (StudentId, Name, Course) VALUES
    (2, '임꺽정', '국어');
INSERT INTO Students_1NF (StudentId, Name, Course) VALUES
    (3, '전우치', '사회'),
    (3, '전우치', '국어'),
    (3, '전우치', '영어');

-- Course 속성이 원자값으로 변경되어 1정규형을 만족
SELECT * FROM Students_1NF;


/* 2정규형 */
DROP TABLE IF EXISTS CourseRegist;
CREATE TABLE CourseRegist (
    StudentId Int,
    CourseId Int,
    InstructorName VARCHAR(255),
    CourseName VARCHAR(255),
    PRIMARY KEY (StudentId, CourseId)	-- 복합 기본키
);

INSERT INTO CourseRegist VALUES
	(1, 101, '홍길동', '데이터베이스'),
    (1, 102, '이영희', '자료구조'),
    (2, 101, '홍길동', '데이터베이스'),
    (2, 103, '김철수', '알고리즘');

SELECT * FROM CourseRegist;

-- 삭제이상 : 학생 1번, 102번 강의 수강 정보를 취소하게 되면 이영희 강사의 자료구조라는 강의 정보가 사라짐.
-- 삽입이상 : 새로운 강의 103, 전우치교수의 컴퓨터도술 강의가 개설되면 학생번호에 null값 삽입 문제가 발생
-- 수정이상 : 홍길동 교수가 데이터베이스 강의 대신 안드로이드 강의를 맡게되면 데이터 불일치 발생 가능성이 있음.

-- 제 2 정규형으로 테이블을 분해
-- CourseRegist( StudentId(PK), CourseId(PK), InstructorName, CourseName )
-- 부분 함수 종속이 존재  CourseId -> InstructorName, CourseName
-- 부분 함수 종속성 제거
-- Enrollment ( StudentId(PK), CourseId(PK) )
-- Course ( CourseId(PK), InstructorName, CourseName )
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;

-- 분리 테이블 수강참여
CREATE TABLE Enrollment (
	StudentId INT, 
    CourseId INT,
	PRIMARY KEY (StudentId, CourseId)
);
-- 분리 테이블 2 강좌
CREATE TABLE Course (
	CourseId INT PRIMARY KEY,
    InstructorName VARCHAR(255),
    CourseName VARCHAR(255)
);

-- 기존 데이터 복사하여 삽입
INSERT INTO Enrollment (StudentId, CourseId)
	SELECT StudentId, CourseId FROM CourseRegist;
    
-- 중복 데이터 제거하여 삽입
INSERT INTO Course (CourseId, InstructorName, CourseName)
	SELECT DISTINCT CourseId, InstructorName, CourseName FROM CourseRegist;

-- 테이블 정보 확인
SELECT * FROM Enrollment;
SELECT * FROM Course;

-- 삭제이상없음 : 학생 1번, 102번 강의 수강 정보를 취소하더라도, 이영희 강사의 자료구조라는 강의 정보는 별개의 테이블에 유지
DELETE FROM Enrollment WHERE StudentId = 1 AND CourseId = 102;
-- 삽입이상없음 : 새로운 강의 104, 전우치교수의 컴퓨터도술 강의가 개설되더라도 null 값 포함되지 않음
INSERT INTO Course VALUES (104, '전우치', '컴퓨터도술');
-- 수정이상없음 : 홍길동 교수가 데이터베이스 강의 대신 안드로이드 강의를 맡게되더라도 한 튜플(행)만 수정하여 데이터 불일치 가능성 없음.
UPDATE Course SET CourseName = '안드로이드' WHERE InstructorName = '홍길동';

-- 부분함수 종속을 제거하여 완전 함수 종속으로 테이블을 분해하면 2정규형 만족


/* 3정규형 */
CREATE TABLE StudentCourse (
	StudentId Int,
    CourseId Int,
    InstructorName VARCHAR(255),
    PRIMARY KEY (StudentId)
);
-- 학생이 특정 강의에 등록하고, 특정 강의는 특정 강사가 가르치는 상태
-- 함수 종속성 분석,  StudentId -> CourseId, CourseId -> InstructorName
-- 이행적 종속 StudentId -> InstructorName, 학생번호를 알면 강사 이름을 알 수 있는 상태
INSERT INTO StudentCourse VALUES
	(1, 101, '김강사'), (2, 102, '이강사'), (3, 103, '박강사'), (4, 101, '김강사');

SELECT * FROM StudentCourse;
-- 이상현상
-- 삭제이상 : 2번 학생이 수강을 취소하면 102번 강의(이강사) 정보가 삭제됨.
-- 삽입이상 : 104번 장강사 강의를 개설하면, 학생번호 null 값 삽입 문제 발생 
-- 수정이상 : 101번 강의를 조강사 맡게 될 경우 데이터 불일치 문제 발생 가능성 생김.

-- 테이블 분해
CREATE TABLE Instructor (
	CourseId INT PRIMARY KEY,     -- 이행적 종속 관계의 결정자를 기본키로 테이블 분해
    InstructorName VARCHAR(255)	  -- 종속자
);
INSERT INTO Instructor (CourseId, InstructorName)
	SELECT DISTINCT CourseId, InstructorName FROM StudentCourse;

ALTER TABLE StudentCourse DROP COLUMN InstructorName;	-- 기존 테이블의 컬럼 (이행종속자) 삭제

-- 이행적 종속성 제거
-- Before :  StudentId -> CourseId, CourseId -> InstructorName
-- StudentCourse ( StudentId(PK), CourseId, InstructorName )

-- After
-- StudentId -> CourseId      // StudentCourse ( StudentId(PK), CourseId )
-- CourseId -> InstructorName // Instructor    ( CourseId(PK), InstructorName )

SELECT * FROM Instructor;
SELECT * FROM StudentCourse;

-- 삭제이상없음 : 2번 학생이 수강을 취소하여도 102번 강의(이강사) 정보는 남아있음.
DELETE FROM StudentCourse WHERE StudentId = 2;
-- 삽입이상없음 : 104번 장강사 강의를 개설하더라도 null값 학생 번호 삽입하지 않음
INSERT INTO Instructor VALUES (104, '장강사');
-- 수정이상없음 : 101번 강의를 조강사 맡게 되어도 데이터 불일치 문제 발생 가능성 없음.
UPDATE Instructor SET InstructorName = '조강사' WHERE CourseId = 101;

-- 3정규형 만족


/* BCNF */
DROP TABLE IF EXISTS StudentCourse;
-- 한 학생은 한 개이상의 특강을 신청할 수 있고,
-- 한 강사는 하나의 특강만 담당할 수 있다고 가정.
CREATE TABLE StudentCourse (
	StudentId Int,
    CourseName VARCHAR(255),
    InstructorName VARCHAR(255),
    PRIMARY KEY (StudentId, CourseName)
);
INSERT INTO StudentCourse VALUES
	(501, '소셜네트워크', '김교수'), (401, '소셜네트워크', '김교수'),
    (402, '인간과동물', '성교수'), (502, '창업전략', '박교수'), (501, '창업전략', '홍교수');
SELECT * FROM StudentCourse;
-- 1, 2, 3정규형 모두 만족
-- StudentCourse ( StudentId(PK), CourseName(PK), InstructorName )
-- InstructorName( 교수이름, 기본키가 아님 ) -> CourseName

-- 함수 종속성 분석
-- ( StudentId, CourseName ) -> InstructorName
-- InstructorName -> CourseName
-- 모든 결정자가 후보키(기본키가 될 수 있는 속성 집합)

-- 이상현상
-- 삭제이상 : 402번 학생이 수강을 취소하면 '인간과동물' 특강 정보와 교수 정보가 사라짐
-- 삽입이상 : 새로운 특강 정보를 개설해서 최교수가 담당하면 학생정보 null값 삽입 문제 발생
-- 수정이상 : 김교수의 특강 제목을 '빅데이터분석'으로 바꾸면 데이터 불일치 가능성 발생

-- 테이블 분해
-- Enroll ( StudentId(PK), InstructorName(PK) )
-- Instructor ( InstructorName(PK), CourseName )
DROP TABLE IF EXISTS Enroll;
DROP TABLE IF EXISTS Instructor;

-- 1. 특강 참여 릴레이션
CREATE TABLE Enroll (
	StudentId INT,
    InstructorName VARCHAR(255),
    PRIMARY KEY ( StudentId, InstructorName )
);
INSERT INTO Enroll
	SELECT StudentId, InstructorName FROM StudentCourse;

-- 2. 교수 특강 릴레이션
CREATE TABLE Instructor (
    InstructorName VARCHAR(255),
	CourseName VARCHAR(255),
    PRIMARY KEY ( InstructorName )
);
INSERT INTO Instructor
	SELECT DISTINCT InstructorName, CourseName FROM StudentCourse;	-- 중복제거
    
SELECT * FROM Enroll;
SELECT * FROM Instructor;

SELECT e.StudentId, i.InstructorName, i.CourseName
FROM Enroll e JOIN Instructor i ON e.InstructorName = i.InstructorName;










