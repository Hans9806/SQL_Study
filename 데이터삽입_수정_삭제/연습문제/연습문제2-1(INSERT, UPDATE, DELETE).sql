-- 데이터 삽입, 추가, 삭제 연습문제 
-- HealthCareManagement2 스키마에서 진행해주세요.
drop schema if exists HealthcareManagement2;
create schema HealthcareManagement2;
use HealthcareManagement2;

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    PhoneNumber VARCHAR(15)
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Type VARCHAR(50) NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);


CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    VisitDate DATE NOT NULL,
    Diagnosis VARCHAR(255) NOT NULL,
    Prescription VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);
-- 문제 1: 'Patients' 테이블에 새로운 환자 추가하기
-- 이름: "John Smith", 생년월일: "1985-02-20", 성별: "M", 전화번호: "123-456-7890"
DESC patients;
SELECT * FROM patients;
INSERT INTO patients (Name, BirthDate, Gender, PhoneNumber)
VALUES ('John Smith','1985-02-20','M','123-456-7890');

-- 문제 2: 'Appointments' 테이블에 새로운 예약 추가하기
-- 환자 ID: 1, 예약 날짜: "2023-04-20", 예약 시간: "10:00", 진료 유형: "General Checkup"
DESC Appointments;
SELECT * FROM Appointments;
INSERT INTO Appointments (PatientID, AppointmentDate, AppointmentTime, Type)
VALUES (1,'2023-04-20','10:00','General Checkup');

-- 문제 3: 'MedicalRecords' 테이블에 새로운 의료 기록 추가하기
-- 환자 ID: 1, 방문 날짜: "2023-04-10", 진단: "Common Cold", 처방: "Rest and hydration"
DESC MedicalRecords;
SELECT * FROM MedicalRecords;
INSERT INTO MedicalRecords (PatientID, VisitDate, Diagnosis, Prescription)
VALUES (1,'2023-04-10','Common Cold','Rest and hydration');

-- 문제 4: 'Patients' 테이블에서 환자의 전화번호 업데이트하기
-- 환자 ID가 1인 환자의 전화번호를 "987-654-3210"으로 변경하기
DESC Patients;
SELECT * FROM Patients;
UPDATE Patients
SET PhoneNumber = '987-654-3210' 
WHERE PatientID = 1;

-- 문제 5: 'Appointments' 테이블에서 예약 시간 변경하기
-- 환자 ID가 1이고 예약 날짜가 "2023-04-20"인 예약의 시간을 "14:00"으로 변경하기
DESC Appointments;
SELECT * FROM Appointments;
UPDATE Appointments
SET AppointmentTime = '14:00'
WHERE PatientID = 1 AND AppointmentDate = '2023-04-20';

-- 문제 6: 'MedicalRecords' 테이블에서 진단 정보 업데이트하기
-- 환자 ID가 1이고 방문 날짜가 "2023-04-10"인 기록의 진단을 "Seasonal Allergies"로 변경하기
DESC MedicalRecords;
SELECT * FROM MedicalRecords;
UPDATE MedicalRecords
SET Diagnosis = 'Seasonal Allergies'
WHERE PatientID = 1 AND VisitDate = '2023-04-10';

-- 문제 7: 'Patients' 테이블에서 특정 환자 삭제하기
-- 환자 ID가 1인 환자 삭제하기
SHOW ENGINE INNODB STATUS;
DESC Patients;
SELECT * FROM Patients;
SHOW CREATE TABLE Patients;
DELETE FROM Patients
WHERE PatientID = 1;


-- 문제 8: 'Appointments' 테이블에서 특정 날짜의 모든 예약 삭제하기
-- 예약 날짜가 "2023-04-20"인 모든 예약 삭제하기
DESC Appointments;
SELECT * FROM Appointments;
DELETE FROM Appointments
WHERE AppointmentDate = '2023-04-20';

-- 문제 9: 'MedicalRecords' 테이블에서 특정 진단을 가진 모든 기록 삭제하기
-- 진단이 "Seasonal Allergies"인 모든 의료 기록 삭제하기
DESC MedicalRecords;
SELECT * FROM MedicalRecords;
DELETE FROM MedicalRecords
WHERE Diagnosis ='Seasonal Allergies';

-- 문제 10: 'Patients' 테이블에 여러 환자 동시에 추가하기
-- 환자 정보: ("Alice Johnson", "1992-08-24", "F", "555-1234"), ("Bob Williams", "1980-03-15", "M", "555-5678")
DESC Patients;
SELECT * FROM Patients;
INSERT INTO Patients (Name, BirthDate, Gender, PhoneNumber)
VALUES ('Alice Johnson','1992-08-24','F','555-1234'),
		('Bob Williams','1980-03-15','M','555-5678');