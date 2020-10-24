-- Create the Explorers schema

SET ECHO ON;
SET SERVEROUTPUT ON;

DROP TABLE Room_Treasure;
DROP TABLE Explorer_Treasure;
DROP TABLE Room;
DROP TABLE Explorer;
DROP TABLE Treasure;

CREATE TABLE Room (
Room_ID NUMBER,
Name VARCHAR2(20),
Descr	 VARCHAR2(30),
Next NUMBER,
CONSTRAINT Room_PK PRIMARY KEY (Room_ID)
);

CREATE TABLE Explorer (
Exp_ID NUMBER,
Name VARCHAR2(20),
Username VARCHAR2(20),
Room_ID NUMBER,
Max_Item_Count NUMBER,
Max_Bag_Weight  NUMBER,
Max_Item_Weight	 NUMBER,
CONSTRAINT Exp_PK PRIMARY KEY (Exp_ID)
);

DROP SEQUENCE eid_seq;

CREATE SEQUENCE eid_seq
  MINVALUE     0
  START WITH   0
  INCREMENT BY 1;

CREATE TABLE Treasure (
Tres_ID		 NUMBER,
Name		 VARCHAR2(20),
Descr		 VARCHAR2(30),
Value		 NUMBER,
Weight		 NUMBER(8,3),
CONSTRAINT Tres_PK PRIMARY KEY (Tres_ID)
);

CREATE TABLE Room_Treasure
(
	Room_ID		 NUMBER
,	Tres_ID		 NUMBER
, CONSTRAINT Room_Tres_PK PRIMARY KEY (Room_ID, Tres_ID)
, CONSTRAINT RID_Room_Tres_FK FOREIGN KEY (Room_ID) REFERENCES Room
, CONSTRAINT TID_Exp_Room_FK  FOREIGN KEY (Tres_ID) REFERENCES Treasure
);

CREATE TABLE Explorer_Treasure
(
	Exp_ID	  	NUMBER
,	Tres_ID	  	NUMBER
, CONSTRAINT Exp_Tres_PK PRIMARY KEY (Exp_ID, Tres_ID)
, CONSTRAINT EID_Exp_Tres_FK FOREIGN KEY (Exp_ID) REFERENCES Explorer
, CONSTRAINT TID_Exp_Tres_FK FOREIGN KEY (Tres_ID) REFERENCES Treasure
);

-- Load explorer

INSERT INTO Explorer (Exp_ID, Name, Username, Room_ID, Max_Item_Count, Max_Bag_Weight, Max_Item_Weight)
VALUES (eid_seq.nextval, 'Zeek', 'jpittges', 1, 2, 53, 5.5);

-- Load rooms

INSERT INTO Room (Room_ID, Name, Descr, Next)
VALUES (1, 'the Start Room', 'A cold, dark place', 2);

INSERT INTO Room (Room_ID, Name, Descr, Next)
VALUES (2, 'Davis 216', 'A place of higher learning', 3);

INSERT INTO Room (Room_ID, Name, Descr, Next)
VALUES (3, 'Davis 225', 'A lab like no other', 4);

INSERT INTO Room (Room_ID, Name, Descr, Next)
VALUES (4, 'the End Room', 'A warm, bright place', -1);

-- Load treasures

INSERT INTO Treasure (Tres_ID, Name, Descr, Value, Weight)
VALUES (1000, 'Golden key', 'Unlocks the first room', 1, 0.1);

INSERT INTO Treasure (Tres_ID, Name, Descr, Value, Weight)
VALUES (1001, 'iPod', 'Plays music', 100, 0.5);

INSERT INTO Treasure (Tres_ID, Name, Descr, Value, Weight)
VALUES (1002, 'DVD Player', 'Plays videos', 150, 5.5);

INSERT INTO Treasure (Tres_ID, Name, Descr, Value, Weight)
VALUES (1003, 'iPad', 'Mini tablet PC', 300, 2.0);

INSERT INTO Treasure (Tres_ID, Name, Descr, Value, Weight)
VALUES (1004, 'Plasma TV', '70-inch flat panel television', 200, 50);

-- Load treasures into rooms

INSERT INTO Room_Treasure (Room_ID, Tres_ID)
VALUES (1, 1000);

INSERT INTO Room_Treasure (Room_ID, Tres_ID)
VALUES (1, 1001);

INSERT INTO Room_Treasure (Room_ID, Tres_ID)
VALUES (2, 1002);

INSERT INTO Room_Treasure (Room_ID, Tres_ID)
VALUES (3, 1003);

INSERT INTO Room_Treasure (Room_ID, Tres_ID)
VALUES (4, 1004);

COMMIT;
-- Move procedure Moves Explorer to the next room
CREATE OR REPLACE PROCEDURE Move
(Explorer_ID Explorer.Exp_ID%TYPE)
IS
new_room Room.Room_ID%TYPE;
check_gameover Room.Room_ID%TYPE;
BEGIN
SELECT Explorer.Room_ID INTO check_gameover
FROM Explorer
WHERE Explorer.Exp_ID = Explorer_ID;
IF check_gameover = -1 THEN
DBMS_OUTPUT.PUT_LINE('GAME OVER');
ELSE
SELECT Next
INTO new_room
FROM Room INNER JOIN Explorer ON Explorer.Room_ID = Room.Room_ID
WHERE Explorer.Exp_ID = Explorer_ID;
-- Updates the Explorer's position to the next room
UPDATE Explorer
SET Room_ID = new_room
WHERE Explorer.Exp_ID = Explorer_ID;
COMMIT;
END IF;
-- Exceptions
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Explorer or Room does not exist');
ROLLBACK;
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('*****ERROR: Explorer did not move successfully.******');
ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE Grab
(Explorer_ID Explorer.Exp_ID%TYPE, Treasure_ID Treasure.Tres_ID%TYPE)
IS
Exp_ID_NotFound EXCEPTION;
PRAGMA EXCEPTION_INIT(Exp_ID_NotFound, -02291);
too_many_items EXCEPTION;
BEGIN
--Evaluates whether the treasure is still available
DELETE FROM Room_Treasure
WHERE Room_Treasure.Tres_ID = Treasure_ID;
IF SQL%ROWCOUNT= 0 THEN
RAISE NO_DATA_FOUND;
END IF;
INSERT INTO Explorer_Treasure (Exp_ID, Tres_ID)
VALUES(Explorer_ID, Treasure_ID);
DBMS_OUTPUT.PUT_LINE('Treasure Successfully Acquired');
COMMIT;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No treasure has been picked up.');
ROLLBACK;
WHEN Exp_ID_NotFound THEN
DBMS_OUTPUT.PUT_LINE('Invalid Explorer ID');
ROLLBACK;
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('You do not have room for this item.');
ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE Grab_All
(Explorer_ID Explorer.Exp_ID%TYPE)
IS
Explorers_Room Room.Room_ID%TYPE;
Treasure_ID Treasure.Tres_ID%TYPE;
BEGIN
SELECT Room_ID
INTO Explorers_Room
FROM Explorer
WHERE Exp_ID = Explorer_ID;

FOR TreasureCursor IN
(SELECT Room_ID, Tres_ID
FROM Room_Treasure) LOOP

IF TreasureCursor.Room_ID = Explorers_Room THEN
Treasure_ID := TreasureCursor.Tres_ID;
Grab(Explorer_ID, Treasure_ID);
END IF;
END LOOP;
END;
/
