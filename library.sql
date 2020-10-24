DROP TABLE Loan;

DROP TABLE Book_Author;

DROP TABLE Review;

DROP TABLE Book;

DROP TABLE Author;

DROP TABLE Publisher;

DROP TABLE Member;

CREATE TABLE Publisher (
Publisher_ID INTEGER,
Name VARCHAR(20),
City VARCHAR(20),
State CHAR(2),
Zip INTEGER,
CONSTRAINT PK_Publisher PRIMARY KEY(Publisher_ID));

CREATE TABLE Book (
ISBN INTEGER,
Catalog_no VARCHAR(25),
Title VARCHAR(65),
Edition INTEGER,
Publisher INTEGER CONSTRAINT PublisherRequired NOT NULL,
Pub_date DATE,
Num_Pages INTEGER,
Media VARCHAR(12) CONSTRAINT CorrectMedia CHECK (Media= 'Paperback' OR Media= 'Hard Cover' OR Media= 'Electronic') NOT NULL,
Fiction CHAR(1) CONSTRAINT FictionOption CHECK(Fiction= 'Y' OR Fiction= 'N'),
Language VARCHAR(20) CONSTRAINT LanguageRequired NOT NULL,
CONSTRAINT PK_Book PRIMARY KEY(ISBN),
CONSTRAINT FK_Book FOREIGN KEY(Publisher) REFERENCES Publisher (Publisher_ID));

CREATE TABLE Author (
Author_ID INTEGER,
First VARCHAR(20),
Last VARCHAR(20),
DOB DATE,
Gender CHAR(1) CONSTRAINT AuthorGender CHECK(Gender= 'M' OR Gender= 'F'),
CONSTRAINT PK_Author PRIMARY KEY(Author_ID));

CREATE TABLE Member (
Member_ID INTEGER,
First VARCHAR(20),
Last VARCHAR(20),
DOB DATE,
Gender CHAR(1) CONSTRAINT MemberGender CHECK(Gender= 'M' OR Gender= 'F'),
Affiliation VARCHAR(10) CONSTRAINT CoorectAffiliation CHECK(Affiliation= 'Students' OR Affiliation= 'Staff' OR Affiliation= 'Faculty'),
Member_since DATE,
CONSTRAINT PK_Member PRIMARY KEY(Member_ID));

CREATE TABLE Book_Author (
ISBN INTEGER,
Author_ID INTEGER,
Position INTEGER CONSTRAINT PositionRequired NOT NULL,
CONSTRAINT PK_BookAuthor PRIMARY KEY (ISBN, Author_ID),
CONSTRAINT FK_BookAuthor1 FOREIGN KEY(ISBN) REFERENCES Book (ISBN),
CONSTRAINT FK_BookAuthor2 FOREIGN KEY(Author_ID) REFERENCES Author (Author_ID));

CREATE TABLE Loan (
ISBN INTEGER,
Member_ID INTEGER,
Check_out_date DATE,
Due_date DATE CONSTRAINT DueDateRequired NOT NULL,
Return_date DATE,
Fees DECIMAL(8, 2),
CONSTRAINT PK_Loan PRIMARY KEY(ISBN, Member_ID),
CONSTRAINT FK_Loan1 FOREIGN KEY(ISBN) REFERENCES Book (ISBN),
CONSTRAINT FK_Loan2 FOREIGN KEY(Member_ID) REFERENCES Member(Member_ID));

CREATE TABLE Review (
ISBN INTEGER,
Member_ID INTEGER,
Review_date DATE,
Rating INTEGER CONSTRAINT RatingRequired NOT NULL,
Comments VARCHAR(150),
CONSTRAINT PK_Review PRIMARY KEY(ISBN, Member_ID),
CONSTRAINT FK_Review1 FOREIGN KEY(ISBN) REFERENCES Book (ISBN),
CONSTRAINT FK_Review2 FOREIGN KEY(Member_ID) REFERENCES Member(Member_ID));

