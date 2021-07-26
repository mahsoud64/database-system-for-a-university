DROP DATABASE IF EXISTS RS
CREATE DATABAse RS
Use RS
Use master

DROP TABLE rcLocation
DROP TABLE Reservation 
DROP TABLE Immovable
DROP TABLE Loan
DROP TABLE Movable 
DROP TABLE courseOffering
DROP TABLE Privlidges 
DROP TABLE Staff 
DROP TABLE Student 
DROP TABLE Acquisition 
DROP TABLE Member 
DROP TABLE Category
DROP TABLE enrolment 
DROP TABLE Catalogue
DROP TABLE ResourceInv

go

CREATE TABLE ResourceInv(
resourceID Varchar(15) primary key NOT NULL,
Rcname Varchar(20),
make Char(15) NOT NULL,
Rcversion Varchar(30) NOT NULL,
Rcstatus Char(20) NOT NULL,
Rclocation char(20) NOT NULL,
);
go

INSERT INTO ResourceInv VALUES ('MCE002', 'MACBOOK AIR', 'APPLE', '10.15.7.', 'available', 'callaghan')
INSERT INTO ResourceInv VALUES ('M23ES','XPS.V2', 'DELL', '13 9310', 'available', 'callaghan')
INSERT INTO ResourceInv VALUES ('ZX9DS', 'CANON POWERSHOTV2', 'CANON', '5D Mark IV', 'unavailable', 'port macquarie')
INSERT INTO ResourceInv VALUES ('MC343', 'MACBOOK PRO', 'APPLE', '10.02.7', 'available', 'callaghan')
INSERT INTO ResourceInv VALUES ('RW4R3','XPS', 'DELL', '13 9653', 'available', 'callaghan')
INSERT INTO ResourceInv VALUES ('RG52F', 'CANON POWERSHOT', 'CANON', '4D Mark V', 'available', 'callaghan')
go

CREATE TABLE Catalogue (
catalogueName Varchar(20) NOT NULL,
resourceName Varchar(15) primary key NOT NULL,
rcLocation Varchar(20) NOT NULL,
categories char (15) NOT NULL,
);
go

INSERT INTO Catalogue VALUES ('immovable', 'ICT 784', 'callaghan', 'labs')
INSERT INTO Catalogue VALUES ('movable', 'Sony', 'callaghan', 'speaker')
INSERT INTO Catalogue VALUES ('immovable','ICT 709', 'port macquarie', 'labs')
INSERT INTO Catalogue VALUES ('movable', 'Samsung', 'callaghan', 'speaker')
INSERT INTO Catalogue VALUES ('movable', 'Apple', 'callaghan', 'speaker')
INSERT INTO Catalogue VALUES ('immovable','ICT 786', 'port macquarie', 'labs')
go

CREATE TABLE Member (
memberID Varchar(10) primary key NOT NULL,
memberName char(20),
mobileNumber int NOT NULL,
email Varchar(30) NOT NULL,
homeAddress Varchar(20),
memberStatus VARCHAR(10) default 'active' CHECK(memberStatus IN ('active', 'inactive')) NOT NULL
);
go

INSERT INTO Member VALUES ('C001220001', 'John Little',0431223311, 'johnlittle@hotmail.com', '3-28 Ralph St', 'active')
INSERT INTO Member VALUES ('C938874002', 'Mary Chang', 0234532322, 'marychang@yahoo.com','24-20 Sunset Blvd', 'active')
INSERT INTO Member VALUES ('C432832003', 'Kevin Mark', 0237436353, 'kevinmark@hotmail.com', '23-78 Scott St', 'active')
INSERT INTO Member VALUES ('C861220091', 'Jeff Dunham',0494888039, 'jeffdunham@hotmail.com', '8-54 Birm St', 'active')
INSERT INTO Member VALUES ('C957874632', 'Jason Karibu',0434532312,'jasonkaribu@gmail.com','3-30 Para St', 'inactive')
INSERT INTO Member VALUES ('C432878773', 'Alexis Paul', 0437479353, 'alexispaul@hotmail.com', '23-40 Baverley St', 'inactive')
go

CREATE TABLE Student(
studentID Varchar(10) NOT NULL,
studentName Char(20) NOT NULL,
courseCode Varchar(10) NULL,
degree VarChar(10) NOT NULL,
studentRcPoints int NULL, 

);
go

INSERT INTO Student VALUES('C3343434','Kevin Mark', 'COMP1140', 'BA', 4 ) 
INSERT INTO Student VALUES('C3348890','Mary Chang', 'INFT2150', 'PHD', 6)
INSERT INTO Student VALUES('C3568809','Jeff Karinga','eng1110', 'BA', 6) 
INSERT INTO Student VALUES('C3678890','Alex Wasabi', 'INFT2150', 'BA', 6)
INSERT INTO Student VALUES('C3510809', 'Greg Alison', 'SENG1160', 'BA', 2)
go

CREATE TABLE Staff(
staffID Varchar(10) primary key NOT NULL,
dateOfBirth date NOT NULL,
phoneNumber int NOT NULL, 
position Char(15) NULL,
staffStatus Varchar(10) DEFAULT 'active' CHECK (staffStatus IN ('active', 'inactive')) NOT NULL
);
go

INSERT INTO Staff VALUES('L000011233', '1999-09-14', 0448983931, 'front desk', 'active')
INSERT INTO Staff VALUES('L000011243', '1995-03-23', 0488986573, 'manager', 'active')
INSERT INTO Staff VALUES('L000033685', '1997-05-17', 0483377721, 'IT specialist', 'active')
go

CREATE TABLE Movable(
movableName Varchar(20) primary key NOT NULL,
resourceID Varchar(15) NOT NULL,
manufacturer Varchar(20) NOT NULL,
model VarChar(15) NOT NULL,
movableYear int NOT NULL,

FOREIGN KEY(resourceID) References ResourceInv (resourceID)
	ON UPDATE CASCADE ON DELETE NO ACTION

);
go

INSERT INTO Movable VALUES('MACBOOK PRO', 'M23ES', 'Apple', 'A1278', 2018)
INSERT INTO Movable VALUES('CANON POWERSHOTV2', 'ZX9DS', 'CANON', '5D Mark IV', 2017)
INSERT INTO Movable VALUES('CANON POWERSHOT', 'RG52F', 'CANON',  '4D Mark V', 2016)
INSERT INTO Movable VALUES('XPS', 'RW4R3','DELL', '13 9653', 2019)
INSERT INTO Movable VALUES('MACBOOK AIR', 'MC343', 'APPLE','10.02.7', 2016)
go


CREATE TABLE Immovable(
resourceName Varchar(15) NOT NULL,
roomID VarChar(30) primary key NOT NULL,
immLocation Varchar(20) NOT NULL,
capacity int NOT NULL,
FOREIGN KEY(resourceName) REFERENCES Catalogue (resourceName)
	ON UPDATE CASCADE ON DELETE NO ACTION

);
go

INSERT INTO Immovable VALUES('ICT 784', 'computer lab 235E', 'callaghan', 14) 
INSERT INTO Immovable VALUES('ICT 709', 'computer lab 151E', 'port macquarie', 8)
INSERT INTO Immovable VALUES('ICT 786', 'computer lab 482E', 'port macquarie', 12)
go

CREATE TABLE Loan(
loanID varchar(15)  NOT NULL, 
memberID VARCHAR(10) NOT NULL,
movableName Varchar(20) NOT NULL,
dateTimeBorrowed datetime NOT NULL,
dateTimeReturned datetime NOT NULL,
paymentDetails Varchar(20) NOT NULL,
PRIMARY KEY(loanID, movableName),
FOREIGN KEY(memberID) References Member (memberID)
	ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(movableName) References Movable (movableName)
	ON UPDATE CASCADE ON DELETE NO ACTION
	

);
go

INSERT INTO Loan VALUES('A000001234', 'C001220001','MACBOOK PRO', '2019-4-20','2019-4-22', 'Mastercard')
INSERT INTO Loan VALUES('A000002345', 'C432878773','CANON POWERSHOTV2', '2019-4-25','2019-4-27', 'Mastercard')
INSERT INTO Loan VALUES('A000004567', 'C432832003','CANON POWERSHOT', '2020-4-11','2020-4-12', 'American express')
INSERT INTO Loan VALUES('A000008782', 'C861220091', 'MACBOOK AIR', '2020-03-11', '2020-03-15', 'Mastercard')
go


CREATE TABLE Reservation(
ReservationNo Varchar(15) primary key NOT NULL,
staffID varchar(10) NULL,
memberID Varchar(10) NOT NULL,
reservationDateTime date NOT NULL,
roomID VarChar(30) NOT NULL,
availablity VarChar(10) DEFAULT 'active' CHECK (availablity IN('Active', 'Inactive')) NOT NULL
FOREIGN KEY(staffID) References Staff (staffID)
	ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(memberID) References Member (memberID)
	ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(roomID) References Immovable (roomID)
    ON UPDATE CASCADE ON DELETE NO ACTION,


);
go

INSERT INTO Reservation VALUES('RE897', 'L000011233', 'C432832003', '2020-05-01', 'computer lab 235E', 'Active')
INSERT INTO Reservation VALUES('RE850', 'L000011243', 'C001220001', '2020-06-05', 'computer lab 151E','Active')
INSERT INTO Reservation VALUES('RE844', 'L000033685', 'C432878773', '2020-09-19', 'computer lab 482E', 'Active')
go

CREATE TABLE enrolment (
memberID Varchar(10) primary key NOT NULL,
dateOfEnrolment date NOT NULL,
dateOfExpiry date NOT NULL ,
);
go

INSERT INTO enrolment VALUES('C001220001', '2020-01-10', '2021-05-01');
INSERT INTO enrolment VALUES('C001235241', '2019-01-01', '2021-12-01');
INSERT INTO enrolment VALUES('C432832003', '2020-05-17', '2021-01-01');
go

CREATE TABLE Acquisition (
acquisitionID Varchar(10) primary key NOT NULL,
memberID VarChar(10) NOT NULL, 
resourceName Varchar(15) NOT NULL,
model Varchar(30) NOT NULL,
make Varchar(20) NOT NULL,
RcDescription Varchar(20) NOT NULL,
urgency Varchar(20)  DEFAULT 'Urgent' CHECK (urgency IN ('Urgent', 'Non Urgent')) NOT NULL,
FOREIGN KEY(memberID) References Member (memberID)
	ON UPDATE CASCADE ON DELETE NO ACTION
	
	);
go

INSERT INTO Acquisition VALUES('AC883', 'C001220001', 'MACBOOK AIR','10.15.7.', 'APPLE', 'computer laptop', 'Urgent')
INSERT INTO Acquisition VALUES('AC263', 'C938874002', 'MACBOOK PRO', '10.02.7', 'APPLE', 'computer laptop', 'Non Urgent')
INSERT INTO Acquisition VALUES('AC098', 'C432832003', 'CANON POWERSHOT', '4D Mark IV', 'CANON', 'camera', 'Non Urgent')
go

CREATE TABLE Category( 
categoryCode Varchar(10) primary key NOT NULL,
categoryName Varchar(10),
description Varchar(20) NOT NULL,
);
go

INSERT INTO Category VALUES('A56859', 'Studios', 'Bose headphones')
INSERT INTO Category VALUES('A56898', 'Cameras', 'Canon Cameras')
INSERT INTO Category VALUES('A56864', 'Speakers', 'Samsung')
INSERT INTO Category VALUES('A5685-434', 'Lab', 'Computer Lab')
INSERT INTO Category VALUES('A5685-334', 'studio', 'Music studio')
INSERT INTO Category VALUES('A50024', 'Speakers', 'Sony')
INSERT INTO Category VALUES('A59924', 'Cameras', 'GoPro')
go



CREATE TABLE Privlidges(
memberID Varchar(10) NOT NULL,
privlidgeID Varchar(20) NOT NULL,
privlidgeType Char(30) NOT NULL,
privlidgeDuration Char(60) NOT NULL,
maxAmount int NOT NULL,
primary key(privlidgeID),
Foreign Key (memberID) REFERENCES Member(memberID)
	ON UPDATE CASCADE ON DELETE NO ACTION

);
go

INSERT INTO Privlidges VALUES('C001220001','PR2990', 'STUDENT CLEARANCE', 'Valid till student graduates', 2)
INSERT INTO Privlidges VALUES('C938874002','PR6888', 'STAFF CLEARANCE', 'Valid until certain staff resigns or gets dismissed', 2)
INSERT INTO Privlidges VALUES('C432832003','PR8677', 'STUDENT CLEARANCE', 'Valid till student graduates', 2)
INSERT INTO Privlidges VALUES('C432878773','PR8871','MEMBER CLEARANCE', 'Valid till end of contract', 2)
go

CREATE TABLE courseOffering(
offeringID Varchar(20) primary key NOT NULL, 
privlidgeID Varchar(20) NOT NULL,
yearOffered int NOT NULL,
semesterOffered Varchar(20) NOT NULL,
startDate date NOT NULL,
endDate date NOT NULL,
FOREIGN KEY (privlidgeID) REFERENCES Privlidges (privlidgeID)
	ON UPDATE CASCADE ON DELETE NO ACTION 

);
go

INSERT INTO courseOffering VALUES('CO288-678', 'PR6888', 2020, 'semester 2', '2020-04-12', '2023-06-01')
INSERT INTO courseOffering VALUES('CO668-911', 'PR2990', 2019, 'semester 2', '2019-07-03', '2022-06-01')
INSERT INTO courseOffering VALUES('CO285-044', 'PR8677', 2020, 'semester 1', '2020-01-10', '2023-06-01')
INSERT INTO courseOffering VALUES('CO287-093', 'PR8871', 2018, 'semester 1', '2020-03-11', '2023-02-05')
go

CREATE TABLE rcLocation (
buildingID Varchar(20) primary key NOT NUll,
roomID VarChar(30) NOT NULL,
rcAddress Varchar(30) NOT NULL, 
FOREIGN KEY (roomID) REFERENCES Immovable (roomID)
	ON UPDATE CASCADE ON DELETE NO ACTION 
);

INSERT INTO rcLocation VALUES('ENGINEERING 3ES', 'computer lab 235E', 'Univeristy Drive')
INSERT INTO rcLocation VALUES('Auch A41', 'computer lab 151E', '14-23 macquarie road')
INSERT INTO rcLocation VALUES('MED M67', 'computer lab 482E', 'Univeristy Drive')

SELECT * FROM ResourceInv;
SELECT * FROM Student;
SELECT * FROM Staff;
SELECT * FROM Movable;
SELECT * FROM Immovable;
SELECT * FROM Loan;
SELECT * FROM Reservation;
SELECT * FROM enrolment;
SELECT * FROM Acquisition;
SELECT * FROM Category;
SELECT * FROM Privlidges;
SELECT * FROM courseOffering;
SELECT * FROM rcLocation;



--QUERIES

--Qn1

select studentName 
from Student 
where courseCode='INFT2150'; 

--Qn2

SELECT maxAmount as 'amount of speakers allowed' , studentName, courseCode, categoryName
from Privlidges, Student, courseOffering, Category
where categoryName = 'Speakers'
group by maxAmount, studentName, courseCode, categoryName
order by maxAmount;  

--Qn3

SELECT count(acquisitionID) as ' Total number of acquisitons and reservation requests', staffID, phoneNumber
FROM Acquisition, Staff
GROUP BY staffID, phoneNumber
order by count(acquisitionID); 

--Qn4

select Student.studentName, Movable.model, Category.categoryName, SYSDATETIME() as 'Date Borrowed'
from Student, Category, Movable
where categoryName = 'Cameras' AND NOT Movable.model = 'A1278' AND NOT Movable.model =  '13 9653' AND NOT Movable.model = '10.02.7'
group by studentName, model, categoryName;

--Qn5

select top(1) ResourceInv.resourceID as 'Most loaned resource', ResourceInv.Rcname, dateTimeBorrowed
from Loan, ResourceInv, Movable
where dateTimeBorrowed = '2020-03-11'; 


--Qn6

select reservationDateTime, Reservation.roomID, COUNT(*) as 'Number of reservations made'
from Reservation, rcLocation, Immovable
where resourceName = 'ICT 784'
group by reservationDateTime, Reservation.roomID ; 





