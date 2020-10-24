DROP DATABSE IF EXISTS 'HKCDataBase';
CREATE DATABASE 'HKCDataBase';
USE 'HKCDataBase';

SET NAMES utf8;
SET character_set_client = utf8mb4;

CREATE TABLE HKCFaculty
(
  FacID INTEGER,
  FirstName VARCHAR(15) CONSTRAINT FirstNameRequired NOT NULL,
  LastName VARCHAR(15) CONSTRAINT LastNameRequired NOT NULL,
  DOB VARCHAR(15),
  CONSTRAINT PKHKCFaculty PRIMARY KEY (FacID)
);

CREATE TABLE Administrators
(
  FacID INTEGER,
  StaffTitle VARCHAR(10),
  Availability VARCHAR(20),
  CONSTRAINT PKAdministrators PRIMARY KEY (FacID),
  CONSTRAINT FKAdministrators FOREIGN KEY (FacID) REFERENCES HKCFaculty(FacID) ON DELETE CASCADE
);

CREATE TABLE Coaches
(
  FacID INTEGER,
  StudentID NUMBER,
  Class VARCHAR(2),/*CONSTRAINT TO CHECK TYPE*/
  LeaveDate DATE,
  Availability VARCHAR(20),
  CONSTRAINT PKCoaches PRIMARY KEY (FacID),
  CONSTRAINT FKCoaches FOREIGN KEY (FacID) REFERENCES HKCFaculty(FacID) ON DELETE CASCADE
);

CREATE TABLE Courses
(
  CourseID VARCHAR(8),
  Subject VARCHAR(15),
  CourseName VARCHAR(50),
  CONSTRAINT PKCourses PRIMARY KEY (CourseID)
);

CREATE TABLE AcademicCoaching
(
  FacID INTEGER,
  CourseID VARCHAR(7),
  CONSTRAINT PKAcademicCoaching1 PRIMARY KEY (FacID, CourseID),
  CONSTRAINT FKAcademicCoahcing1 FOREIGN KEY (FacID) REFERENCES Coaches (FacID) ON DELETE CASCADE,
  CONSTRAINT FKAcademicCoaching2 FOREIGN KEY (CourseID) REFERENCES Courses (CourseID) ON DELETE CASCADE
);

-- The following sequence is created to create faculty id's as new data is
-- inserted into the table
CREATE SEQUENCE facIDSeq
START WITH 1
INCREMENT BY 1;


-- Insertion of accounting courses begins here
INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG211', 'Accounting', 'Fundamentals of Financial Accounting');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG212', 'Accounting', 'Fundamentals of Managerial Accounting');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG311', 'Accounting', 'Cost Accounting');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG312', 'Accounting', 'Accounting Information Systems');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG313', 'Accounting', 'Intermediate Accounting 1');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG314', 'Accounting', 'Intermediate Accounting 2');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG401', 'Accounting', 'International Accounting');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG411', 'Accounting', 'Federal Taxation');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG412', 'Accounting', 'Advanced Taxation');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG413', 'Accounting', 'Advanced Financial Topics');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG414', 'Accounting', 'Auditing');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG415', 'Accounting', 'Accounting Theory');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG416', 'Accounting', 'Governmental and Not-For-Profit Accounting');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG471', 'Accounting', 'Special Topics in Accounting');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG472', 'Accounting', 'Independednt Study');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG488', 'Accounting', 'Final Honors Project');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ACTG490', 'Accounting', 'Accounting Internship');
-- Insertion of accounting courses ends here

-- Insertion of Antrhopological Sciences begins here
INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC101', 'Antropology', 'Anthropology of the Human Past');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC103', 'Antropology', 'Ancient Worlds of the Maya, the Aztec, and the Inka');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC201', 'Antropology', 'Introduction to Anthropological Research');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC203', 'Antropology', 'Bigfoot Stole My UFO!: Critically engaging
with Science, Pseudoscience, and the Paranormal');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC210', 'Antropology', 'Introduction to Forensic Anthropolgy');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC211', 'Antropology', 'Forensic Archaeology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC301', 'Antropology', 'Principles of Archaeology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC302', 'Antropology', 'Principles of Biological Anthropolgy');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC303', 'Antropology', 'Quantitative and Computer Methods in Anthropolgy');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC320', 'Antropology', 'Human Osteology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC321', 'Antropology', 'Archaeological Field and Lab Methods');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC330', 'Antropology', 'Primatology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC333', 'Antropology', 'World Prehistory');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC361', 'Antropology', 'Human Impacts on the Prehistoric Environment');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC400', 'Antropology', 'Senior Seminar');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC401', 'Antropology', 'Anthropological Theory');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC410', 'Antropology', 'Paleoanthropology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC420', 'Antropology', 'Advanced Forensic Anthropology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC430', 'Antropology', 'Bioarchaeology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC488', 'Antropology', 'Final Honors Project');\

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC493', 'Antropology', 'Field School in Archaeology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC495', 'Antropology', 'Seminar in Antrhopological Sciences');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC496', 'Antropology', 'Seminar in Biological Anthropology');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC497', 'Antropology', 'Seminar in Archaeological Anthropolgy');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC498', 'Antropology', 'Independent Study');

INSERT INTO Courses (CourseID, Subject, CourseName)
VALUES('ANSC499', 'Antropology', 'Internship');
-- Antrhopological Sciences insertion ends here

