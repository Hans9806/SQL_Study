/*
# 연습문제
HealthcareManagement 데이터베이스 에서 ALTER를 사용해서 테이블 구조를 변경해보세요.

### 문제 1: `Patients` 테이블에 주소 정보를 추가하기

`Patients` 테이블에 `Address` 열(문자열 타입)을 추가하세요.

### 문제 2: `Doctors` 테이블에서 `HireDate` 열의 데이터 타입 변경하기

`Doctors` 테이블의 `HireDate` 열의 데이터 타입을 `DATE`에서 `DATETIME`으로 변경하세요.

### 문제 3: `Appointments` 테이블에 예약 시간을 포함하는 새 열 추가하기

`Appointments` 테이블에 `AppointmentTime` 열(`TIME` 타입)을 추가하여, 예약 날짜와 별개로 시간을 저장할 수 있게 하세요.

### 문제 4: `Appointments` 테이블에서 `Status` 열 삭제하기

`Appointments` 테이블에서 `Status` 열을 삭제하세요. (실제 운영 환경에서는 중요한 데이터를 삭제하기 전에 데이터의 백업과 팀 내 승인 과정을 거치는 것이 좋습니다.)

### 문제 5: `Doctors` 테이블에 `PhoneNumber` 열 추가하기

`Doctors` 테이블에 연락처 정보로 사용될 `PhoneNumber` 열(`VARCHAR(255)`)을 추가하되, 휴대폰 번호가 고유하도록 설정하세요. 
*/
SELECT * FROM Patients;
ALTER TABLE Patients ADD COLUMN Address VARCHAR(255);

SELECT * FROM Doctors;
DESCRIBE Doctors;
ALTER TABLE Doctors MODIFY COLUMN HireDate DATETIME;

SELECT * FROM Appointments;
DESCRIBE Appointments;
ALTER TABLE Appointments ADD COLUMN AppointmentTime TIME;

ALTER TABLE Appointments DROP COLUMN Status;

ALTER TABLE Doctors ADD COLUMN PhoneNumber VARCHAR(255) NOT NULL UNIQUE;

