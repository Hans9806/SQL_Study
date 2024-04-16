CREATE SCHEMA IF NOT EXISTS nomarlization;
USE nomarlization;

-- 선박정보를 저장하는 테이블
-- 함수종속관계 : shipname -> shiptype
CREATE TABLE Ship (
	shipname VARCHAR(255) PRIMARY KEY,
    shiptype VARCHAR(255)
);

-- 향해 정보를 저장하는 테이블
-- 함수 종속관계 : voyageID -> shipname, cargo
CREATE TABLE Voyage (
	voyageID INT PRIMARY KEY,
    shipname VARCHAR(255),
    cargo VARCHAR(255),
    -- 공유 컬럼을 외래키로
    FOREIGN KEY (shipname) REFERENCES Ship(shipname)
);

-- 향해 날짜와 항구 정보를 저장하는 테이블
-- 함수 종속성 : {voyageID, date} -> port
CREATE TABLE VoyageDetail(
	voyageID INT,
    date DATE,
    port VARCHAR(255),
    PRIMARY KEY (voyageID, date),
    FOREIGN KEY (voyageID) REFERENCES Voyage(voyageID)
);

DESC ship;
DESC voyage;
DESC voyagedetail;

INSERT INTO ship VALUES ('한라호','화물선'), ('백두호','여객선');
SELECT * FROM ship;
INSERT INTO voyage VALUES (101,'한라호','화물컨테이너'),(102,'백두호','고객화물');
SELECT * FROM voyage;
INSERT INTO voyagedetail VALUES (101,'2024-04-15','부산'),(102,'2024-04-16','인천');
SELECT * FROM voyagedetail;

-- 테이블 조인하여 보기
SELECT v.voyageID, v.shipname, s.shiptype, v.cargo, vd.date, vd.port FROM voyage v
JOIN voyagedetail vd ON v.voyageID = vd.voyageID
JOIN ship s ON s.shipname = v.shipname;