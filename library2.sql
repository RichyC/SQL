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
CONSTRAINT FK_BookAuthor1 FOREIGN KEY(ISBN) REFERENCES Book (ISBN),
CONSTRAINT FK_BookAuthor2 FOREIGN KEY(Author_ID) REFERENCES Author (Author_ID));

CREATE TABLE Loan (
ISBN INTEGER,
Member_ID INTEGER,
Check_out_date DATE,
Due_date DATE CONSTRAINT DueDateRequired NOT NULL,
Return_date DATE,
Fees DECIMAL(8, 2),
CONSTRAINT FK_Loan1 FOREIGN KEY(ISBN) REFERENCES Book (ISBN),
CONSTRAINT FK_Loan2 FOREIGN KEY(Member_ID) REFERENCES Member(Member_ID));

CREATE TABLE Review (
ISBN INTEGER,
Member_ID INTEGER,
Review_date DATE,
Rating INTEGER CONSTRAINT RatingRequired NOT NULL,
Comments VARCHAR(150),
CONSTRAINT RatingScale CHECK(Rating >= 1 AND Rating <= 4),
CONSTRAINT FK_Review1 FOREIGN KEY(ISBN) REFERENCES Book (ISBN),
CONSTRAINT FK_Review2 FOREIGN KEY(Member_ID) REFERENCES Member(Member_ID));

INSERT INTO Publisher
(Publisher_ID, Name, City, State, Zip)
VALUES
(1000, 'Pearson', 'Chicago', 'IL', 605546);

INSERT INTO Publisher
(Publisher_ID, Name, City, State, Zip)
VALUES
(1005, 'Manning', 'Boston', 'MA', 02201);

INSERT INTO Member
(Member_ID, First, Last, DOB, Gender, Affiliation, Member_since)
VALUES
(900100, 'John', 'Kruck', TO_DATE('2/19/97', 'MM/DD/YY'), 'M', 'Students', TO_DATE('8/15/14', 'MM/DD/YY'));

INSERT INTO Member
(Member_ID, First, Last, DOB, Gender, Affiliation, Member_since)
VALUES
(900255, 'Mary', 'Johnson', TO_DATE('6/1/74', 'MM/DD/YY'), 'F', 'Faculty', TO_DATE('8/10/98', 'MM/DD/YY'));

INSERT INTO Member
(Member_ID, First, Last, DOB, Gender, Affiliation, Member_since)
VALUES
(900267, 'Steve', 'Waybright', TO_DATE('8/19/65', 'MM/DD/YY'), 'M', 'Staff', TO_DATE('12/25/13', 'MM/DD/YY'));

INSERT INTO Author
(Author_ID, First, Last, DOB, Gender)
VALUES
(10, 'Sue', 'Jones', TO_DATE('2/17/87', 'MM/DD/YY'), 'F');

INSERT INTO Author
(Author_ID, First, Last, DOB, Gender)
VALUES
(27, 'Mark', 'Smith', TO_DATE('3/25/64', 'MM/DD/YY'), 'M');

INSERT INTO Author
(Author_ID, First, Last, DOB, Gender)
VALUES
(48, 'Andrew', 'Wiggins', TO_DATE('11/29/95', 'MM/DD/YY'), 'M');

INSERT INTO Book
(ISBN, Catalog_no, Title, Edition, Publisher, Pub_date, Num_Pages, Media, Fiction, Language)
VALUES
(900, 'gm 69-509', 'Java Programming', 1, 1000, TO_DATE('23-May-06', 'DD-Mon-YY'), 325, 'Paperback', 'Y', 'English');

INSERT INTO Book
(ISBN, Catalog_no, Title, Edition, Publisher, Pub_date, Num_Pages, Media, Fiction, Language)
VALUES
(750, 'sn 82-6524', 'The Martian', 1, 1005, TO_DATE('10-Jan-15', 'DD-Mon-YY'), 239, 'Electronic', 'N', 'French');

INSERT INTO Book_Author
(ISBN, Author_ID, Position)
VALUES
(900, 10, 1);

INSERT INTO Book_Author
(ISBN, Author_ID, Position)
VALUES
(900, 48, 2);

INSERT INTO Book_Author
(ISBN, Author_ID, Position)
VALUES
(750, 27, 1);

INSERT INTO Loan
(ISBN, Member_ID, Check_out_date, Due_date, Return_date, Fees)
VALUES
(900, 900100, TO_DATE('3/14/03', 'MM/DD/YY'), TO_DATE('5/30/03', 'MM/DD/YY'), TO_DATE('4/12/03', 'MM/DD/YY'), 0);

INSERT INTO Loan
(ISBN, Member_ID, Check_out_date, Due_date, Return_date, Fees)
VALUES
(900, 900255, TO_DATE('4/15/03', 'MM/DD/YY'), TO_DATE('6/10/03', 'MM/DD/YY'), NULL, 0);

INSERT INTO Loan
(ISBN, Member_ID, Check_out_date, Due_date, Return_date, Fees)
VALUES
(900, 900255, TO_DATE('11/2/04', 'MM/DD/YY'), TO_DATE('1/30/05', 'MM/DD/YY'), TO_DATE('2/14/05', 'MM/DD/YY') , 1.25);

INSERT INTO Review
(ISBN, Member_ID, Review_date, Rating, Comments)
VALUES
(900, 900255, TO_DATE('6/10/03', 'MM/DD/YY'), 4, 'Pretty Good');

