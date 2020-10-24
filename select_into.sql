SET SERVEROUTPUT ON;

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

--Verify the contents of the TextInt and TestTable table 
select* from TextInt;

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
v_int TextInt.int%TYpe;
BEGIN
SELECT text, int INTO v_text, v_int
FROM TextInt
WHERE int = 19;
DBMS_OUTPUT.PUT_LINE('v_text is ' || v_text || ' v_int is '|| v_int);
END;
/

--For demonstration one, v_text should be 'Chris' and v_int should be 3
--For demonstration two, v_text should be 'Sigma' and v_int should be 19
