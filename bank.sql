DROP TABLE Transaction;

DROP TABLE Cust_Account;

DROP TABLE Account;

DROP TABLE Customer;

CREATE TABLE Customer (
Cust_no INTEGER,
First VARCHAR(20),
Last VARCHAR(20),
DOB DATE,
Gender CHAR(1) CONSTRAINT MaleOrFemale CHECK(Gender= 'M' OR Gender= 'F'),
CONSTRAINT PKCustomer PRIMARY KEY (Cust_no));

CREATE TABLE Account (
Acct_no INTEGER,
Type VARCHAR(20) /*constraint on account type*/CONSTRAINT CheckingOrSavings CHECK(Type = 'Checking' OR Type = 'Savings'),
Open_Date DATE,
CONSTRAINT PKAccount PRIMARY KEY (Acct_no));

CREATE TABLE Cust_Account (
Cust_no INTEGER,
Acct_no INTEGER,
Balance INTEGER /*Balance required constraint*/CONSTRAINT BalanceRequired CHECK(Balance >= 0),
CONSTRAINT PKCust_Account PRIMARY KEY (Cust_no, Acct_no),
CONSTRAINT FKCust_no FOREIGN KEY (Cust_no) REFERENCES Customer(Cust_no) ON DELETE CASCADE,
CONSTRAINT FKAcct_no FOREIGN KEY (Acct_no) REFERENCES Account(Acct_no));

CREATE TABLE Transaction (
Trans_no INTEGER,
Acct_no INTEGER,
Trans_Date DATE,
Description VARCHAR(20) /*Description not null*/CONSTRAINT DescriptionRequired NOT NULL,
Amount INTEGER,
CONSTRAINT PKTrans_no PRIMARY KEY (Trans_no),
CONSTRAINT FKAcct_no2 FOREIGN KEY (Acct_no) REFERENCES Account(Acct_no) ON DELETE CASCADE);

--Data loading begins here

INSERT INTO Customer
(Cust_no, First, Last, DOB, Gender)
VALUES
(100, 'Fred', 'Fintstone', TO_DATE('7/1/1960', 'MM/DD/YYYY'), 'M');

INSERT INTO Customer
(Cust_no, First, Last, DOB, Gender)
VALUES
(101, 'Wilma', 'Flintstone', TO_DATE('8/21/1930', 'MM/DD/YYYY'), 'F');

INSERT INTO Customer
(Cust_no, First, Last, DOB, Gender)
VALUES
(102, 'Barney', 'Rubble', TO_DATE('9/3/1960', 'MM/DD/YYYY'), 'M');

INSERT INTO Account
(Acct_no, Type, Open_Date)
VALUES
(2000, 'Checking', TO_DATE('2/14/80','MM/DD/YY'));

INSERT INTO Account
(Acct_no, Type, Open_Date)
VALUES
(2020, 'Savings', TO_DATE('3/25/64', 'MM/DD/YY'));

INSERT INTO Account
(Acct_no, Type, Open_Date)
VALUES
(2031, 'Checking', TO_DATE('11/15/31', 'MM/DD/YY'));

INSERT INTO Cust_Account
(Cust_no, Acct_no, Balance)
VALUES
(100, 2031, 500);

INSERT INTO Cust_Account
(Cust_no, Acct_no, Balance)
VALUES
(102, 2000, 750);

INSERT INTO Cust_Account
(Cust_no, Acct_no, Balance)
VALUES
(101, 2020, 200);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10111, 2031, TO_DATE('11/15/31', 'MM/DD/YY'), 'Deposit', 200);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10112, 2000, TO_DATE('2/14/80', 'MM/DD/YY'), 'Deposit', 400);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10113, 2031, TO_DATE('12/1/31', 'MM/DD/YY'), 'Check 25', -50);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10114, 2020, TO_DATE('3/25/64', 'MM/DD/YY'), 'Deposit', 300);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10115, 2000, TO_DATE('5/21/80', 'MM/DD/YY'), 'Cash', -100);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10116, 2000, TO_DATE('5/25/80', 'MM/DD/YY'), 'Deposit', 800);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10117, 2020, TO_DATE('6/10/64', 'MM/DD/YY'), 'Check 14', -100);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10118, 2031, TO_DATE('7/13/70', 'MM/DD/YY'), 'Deposit', 350);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10119, 2000, TO_DATE('4/30/84', 'MM/DD/YY'), 'Supplies', -350);

--Data loading ends here

--Numbered DML statements 1 through 4

/*
1. Betty Rubble opens a savings account #2045 on October 25, 1982 with
an initial balance of $250. Betty was born on August 3rd 1960.
*/

INSERT INTO Customer
(Cust_no , First, Last, DOB, Gender)
VALUES
(103, 'Betty', 'Rubble', TO_DATE('8/3/1960', 'MM/DD/YYYY'), 'F');

INSERT INTO Account
(Acct_no, Type, Open_Date)
VALUES
(2045, 'Savings', TO_DATE('10/25/1982', 'MM/DD/YYYY'));

INSERT INTO Cust_Account
(Cust_no, Acct_no, Balance)
VALUES
(103, 2045, 250);

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10120, 2045, TO_DATE('10/25/82', 'MM/DD/YY'), 'Deposit', 250);

/*
2. Fred Flintstone deposits 150 on December 8, 2000
*/

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10121, 2031, TO_DATE('12/8/00', 'MM/DD/YY'), 'Deposit', 150);

UPDATE Cust_Account
SET Balance= Balance + 150
WHERE Acct_no= 2031;

/*
3. Barney Rubble Withdraws 250 on Febraury 11, 1971 to pay taxes
*/

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10122, 2000, TO_DATE('2/11/71', 'MM/DD/YY'), 'Withdrawal', -250);

UPDATE Cust_Account
SET Balance= Balance - 250
WHERE Acct_no = 2000;

/*
4. Wilma Flintstone deposits 25 on May 19, 1978
*/

INSERT INTO Transaction
(Trans_no, Acct_no, Trans_Date, Description, Amount)
VALUES
(10123, 2020, TO_DATE('5/19/78', 'MM/DD/YY'), 'Deposit', 25);

UPDATE Cust_Account
SET Balance= Balance + 25
WHERE Acct_no= 2020;
