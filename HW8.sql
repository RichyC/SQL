SET SERVEROUTPUT ON;
DROP PROCEDURE sumColumns;
DROP FUNCTION isFound;
DROP FUNCTION timesFound;
DROP TABLE TextInt;
CREATE TABLE TextInt (
  text VARCHAR2(10),
  int INTEGER
);

INSERT INTO TextInt
(text, int)
VALUES
('Alpha', 1);

INSERT INTO TextInt
(text, int)
VALUES
('Beta', 2);

INSERT INTO TextInt
(text, int)
VALUES
('Chris', 3);

INSERT INTO TextInt
(text, int)
VALUES
('Dodger', 4);

INSERT INTO TextInt
(text, int)
VALUES
('Epsilon', 5);

INSERT INTO TextInt
(text, int)
VALUES
('Fray', 6);

INSERT INTO TextInt
(text, int)
VALUES
('Gamma', 7);

INSERT INTO TextInt
(text, int)
VALUES
('Hydro', 8);

INSERT INTO TextInt
(text, int)
VALUES
('Indigo', 9);

INSERT INTO TextInt
(text, int)
VALUES
('Joshua', 10);

INSERT INTO TextInt
(text, int)
VALUES
('Krypton', 11);

INSERT INTO TextInt
(text, int)
VALUES
('Lorem', 12);

INSERT INTO TextInt
(text, int)
VALUES
('Magnum', 13);

INSERT INTO TextInt
(text, int)
VALUES
('Nero', 14);

INSERT INTO TextInt
(text, int)
VALUES
('Orion', 15);

INSERT INTO TextInt
(text, int)
VALUES
('Pi', 16);

INSERT INTO TextInt
(text, int)
VALUES
('Quotient', 17);

INSERT INTO TextInt
(text, int)
VALUES
('Ricky', 18);

INSERT INTO TextInt
(text, int)
VALUES
('Sigma', 19);

INSERT INTO TextInt
(text, int)
VALUES
('Tau', 20);

INSERT INTO TextInt
(text, int)
VALUES
('Beta', 21);

INSERT INTO TextInt
(text, int)
VALUES
('Chris', 22);

INSERT INTO TextInt
(text, int)
VALUES
('Chris', 23);

--Verify the contents of the TextInt and TestTable table
select* from TextInt;

--Question 2 -4 
--I will use anonymous blocks to demonstrate Question 2 - 4
--SELECT INTO statement copies data from one table and inserts it into another table
--or data slot.
--Selected columns as well as selected column names and types can be copied.
--The following procedure will create two variables and copy the data in one of the rows
--into the variables using the SELECT INTO statement.
--This demonstration will be ran twice on two different rows.

DECLARE
v_text TextInt.text%TYPE;
v_int TextInt.int%TYPE;
BEGIN
SELECT text, int INTO v_text, v_int
FROM TextInt
WHERE int = 3;
DBMS_OUTPUT.PUT_LINE('v_text is ' || v_text || ' v_int is '|| v_int);
END;
/

DECLARE
v_text TextInt.text%TYPE;
v_int TextInt.int%TYPE;
BEGIN
SELECT text, int INTO v_text, v_int
FROM TextInt
WHERE int = 19;
DBMS_OUTPUT.PUT_LINE('v_text is ' || v_text || ' v_int is '|| v_int);
END;
/

--For demonstration one, v_text should be 'Chris' and v_int should be 3
--For demonstration two, v_text should be 'Sigma' and v_int should be 19

--The following procedure demonstrates the Too_Many_Rows exception
--Too_Many_Rows exception is thrown when the SELECT INTO statement returns more
--than one row. SQL does not know which row to return and throws an exception
--Exceptions give the programmer an opportunity to diagnose the programs problem
--in a custom manner most feasible to the programmer.

DECLARE
v_text TextInt.text%TYPE;
v_int TextInt.int%TYPE;
BEGIN
SELECT * INTO v_text, v_int
FROM TextInt;
DBMS_OUTPUT.PUT_LINE('v_text is '|| v_text || ' v_int is '|| v_int);
EXCEPTION
WHEN Too_Many_Rows THEN
DBMS_OUTPUT.PUT_LINE('Too many rows have been returned');
END;
/

--The select statement was coded to return all rows and therefore returned too
--many rows for two variables. Too_Many_Rows exception was thrown and code
--was written to catch the exception and output 'Too many rows have been returned'

--The following anonymous block will demonstrate the No_Data_Found Exception 
--Exceptions give the programmer an opportunity to diagnose the programs problem
--in a custom manner most feasible to the programmer.
--No_Data_Found Exception is designed to handle situations where a table does 
--not find any data corresponding to the query

DECLARE
v_text TextInt.text%TYPE;
v_int TextInt.int%TYPE;
BEGIN
SELECT text, int INTO v_text, v_int
FROM TextInt
WHERE int = 98;
DBMS_OUTPUT.PUT_LINE('v_text is '|| v_text || ' v_int is '|| v_int);
EXCEPTION
WHEN No_Data_Found THEN
DBMS_OUTPUT.PUT_LINE('There is no matching data for this query');
END;
/

--Anonymous block will result in a statement that prints out no data found for this query
--End of Question 4


--Question 5:
--The following procedure will use an explicit cursor to sum the numbers in all
--of the integer columns of the table. The following script will also help explain
--part c of question 8. 

CREATE OR REPLACE PROCEDURE sumColumns
IS
totalSum INTEGER :=0;
currentIntValue INTEGER;
CURSOR SumCursor IS
SELECT int 
FROM TextInt;
BEGIN
OPEN SumCursor;
LOOP
FETCH SumCursor INTO currentIntValue;
EXIT WHEN SumCursor%NotFound;
totalSum := totalSum + currentIntValue;
END LOOP;
CLOSE SumCursor;
DBMS_OUTPUT.PUT_LINE('The total sum of all Integer rows is ' || totalSum);
END;
/

EXEC sumColumns



--An implicit cursor executes the same functionality, but is coded differently
--by using a special version of the FOR statement which declares, opens, iterates,
--and closes a locally name SELECT statement.
--An implicit cursor is not defined within the DECLARE block and the implicit 
--version of the SumCursor used in the sumColumns procedure may be written as 
--follows:
--FOR SumCursor IN
--(select int
--from TextInt) LOOP
--totalSum:= totalSum + currentIntValue;
--END LOOP;
--Because of the nature of an implicit cursor's syntax, it cannot be referenced
--outside of the FOR statement in which it is declared.
--End of Question 5

--question 6:
--the %NotFound cursor attribute is used in this procedure. The %NotFound cursor 
--attribute becomes true if a cursor becomes empty following a Fetch statemnt.
--Once the cursor attribute is TRUE, the statements that are set to run once the 
--condition becomes TRUE begin. 

CREATE OR REPLACE FUNCTION isFound
(aString IN TextInt.text%TYPE) RETURN VARCHAR2 IS
string TextInt.text%TYPE;
FOUND BOOLEAN := FALSE;
CURSOR findString IS
SELECT text 
FROM TextInt;
BEGIN 
OPEN findString;
LOOP 
FETCH findString INTO string;
EXIT WHEN findString%NotFound;
IF string = aString THEN
FOUND := TRUE;
EXIT;
END IF;
END LOOP;
CLOSE findString;
IF FOUND THEN
RETURN(string);
ELSE
RETURN(NULL);
END IF;
END;
/

--The following anonymous blocks will use the function.
--The first anonymous block will return the first row string. 
--The second anonymous block will return the last row string.
--The third anonymous block will return a default statement set for 
--when a string is searched for and not found 

DECLARE 
isFoundResult VARCHAR2(50);
BEGIN 
isFoundResult := isFound('Alpha');
IF isFoundResult IS NULL THEN
DBMS_OUTPUT.PUT_LINE('String was not found');
ELSE 
DBMS_OUTPUT.PUT_LINE('String is: ' || isFoundResult);
END IF;
END; 
/

DECLARE 
isFoundResult VARCHAR2(50);
BEGIN 
isFoundResult := isFound('Tau');
IF isFoundResult IS NULL THEN
DBMS_OUTPUT.PUT_LINE('String was not found');
ELSE 
DBMS_OUTPUT.PUT_LINE('String is: ' || isFoundResult);
END IF;
END; 
/

DECLARE 
isFoundResult VARCHAR2(50);
BEGIN 
isFoundResult := isFound('Zebra');
IF isFoundResult IS NULL THEN
DBMS_OUTPUT.PUT_LINE('String was not found');
ELSE 
DBMS_OUTPUT.PUT_LINE('String is: ' || isFoundResult);
END IF;
END; 
/

--Explicit cursors are different from implicit cursors in that they are 
--declared within the DELCARE section. Explicit cursors are manipulated through
--the OPEN, CLOSE, and FETCH statements. Meanwhile, the implicit cursors are 
--manipulated through the special FOR LOOP statements. Unlike implicit cursors,
--explicit cursors can be referenced anywhere inside the BEGIN section.
--End of Question 6

--The following function answers question 7.

CREATE OR REPLACE FUNCTION timesFound
(aString IN TextInt.text%TYPE) RETURN INTEGER IS
string TextInt.text%TYPE;
numOfMatches INTEGER :=0;
CURSOR countMatches IS
SELECT text 
FROM TextInt;
BEGIN 
OPEN countMatches;
LOOP 
FETCH countMatches INTO string;
EXIT WHEN countMatches%NotFound;
IF string = aString THEN
numOfMatches := numOfMatches + 1;
END IF;
END LOOP;
CLOSE countMatches;
RETURN(numOfMatches);
END;
/

DECLARE 
matchCount INTEGER;
BEGIN 
matchCount := timesFound('Alpha');
DBMS_OUTPUT.PUT_LINE('Your string was found '|| matchCount || ' times.');
END;
/

DECLARE 
matchCount INTEGER;
BEGIN 
matchCount := timesFound('Beta');
DBMS_OUTPUT.PUT_LINE('Your string was found '|| matchCount || ' times.');
END;
/

DECLARE 
matchCount INTEGER;
BEGIN 
matchCount := timesFound('Chris');
DBMS_OUTPUT.PUT_LINE('Your string was found '|| matchCount || ' times.');
END;
/

--I chose to use an explicit cursor because I feel as though I have more control 
--over the cursor itself. I can reference it wherever in the BEGIN block and 
--OPEN and CLOSE it in a controlling manner. I tried to code in a efficient manner
--that requires little code.

---The following comments are written to answer question 8.
--cursor attributes are used to describe a cursor in some manner. 
--ISOPEN is a boolean type which is TRUE if the cursor has been opened or false
--if the cursor has not been opened through the OPEN statement.
--FOUND is a boolean type which returns false if the query does not return any data 
--or true if the query returns data.
--NOTFOUND was explained and demonstrated along with question 6
--ROWCOUNT returns an integer value representing the number of rows fetched by
--the cursor.

--Example for ISOPEN,FOUND, and ROWCOUNT attribute
DECLARE
rowInt TextInt.int%TYPE;
rowCount INTEGER; 
CURSOR iterator IS
SELECT int 
FROM TextInt;
BEGIN 
if (NOT iterator%ISOPEN) THEN
OPEN iterator;
END IF;
FETCH iterator INTO rowInt;
WHILE (iterator%FOUND)LOOP
rowCount := iterator%RowCount;
DBMS_OUTPUT.PUT_LINE('Row count is: '|| rowCount);
FETCH iterator INTO rowInt;
END LOOP;
IF(iterator%ISOPEN) THEN
CLOSE iterator;
END IF;
END;
/

-- The anonymous block above makes use of all three cursor attributes.
--Depending on whether the iterator%ISOPEN attribute is true or false,
--I programmed the anonymous block to close and open the cursor.
--Also, I utilized the rowcount attribute to demonstrate that rowcount 
--increments itself each time it iterates through a row. 
--TextInt table has a total of 23 rows and the rowCount variable will 
--end up being 23 exactly. 





