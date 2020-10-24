SET SERVEROUTPUT ON;
SET ECHO ON;


DROP TABLE Explorer_Treasure;

DROP TABLE Room_Treasure;

DROP TABLE Explorer;

DROP TABLE Room;

DROP TABLE Treasure;

DROP SEQUENCE Exp_IDSeq;

DROP SEQUENCE Tres_IDSeq;

DROP SEQUENCE Room_IDSeq;

CREATE TABLE Room (
  Room_ID NUMBER,
  Name VARCHAR2(20),
  Descr VARCHAR2(35),
  Next NUMBER,
  CONSTRAINT PKRoom PRIMARY KEY (Room_ID),
  CONSTRAINT FKNext FOREIGN KEY (Next) REFERENCES Room (Room_ID));

CREATE TABLE Explorer (
  Exp_ID NUMBER,
  Name VARCHAR2(15),
  Username VARCHAR2(10) CONSTRAINT UsernameRequired NOT NULL,
  Room_ID NUMBER,
  Max_Item_Count NUMBER,
  Max_Bag_Weight NUMBER,
  Max_Item_Weight NUMBER,
  CONSTRAINT PkExplorer PRIMARY KEY (Exp_ID),
  CONSTRAINT FKRoom FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID));

CREATE TABLE Treasure (
  Tres_ID NUMBER,
  Name VARCHAR2(12),
  Descr VARCHAR2(35),
  Value NUMBER,
  Weight NUMBER,
  CONSTRAINT PKTreasure PRIMARY KEY (Tres_ID));

CREATE TABLE Explorer_Treasure (
  Exp_ID NUMBER,
  Tres_ID NUMBER,
  CONSTRAINT PKExp_Tres PRIMARY KEY (Exp_ID, Tres_ID),
  CONSTRAINT FKExp_ID FOREIGN KEY (Exp_ID) REFERENCES Explorer(Exp_ID),
  CONSTRAINT FKTres_IDExp FOREIGN KEY (Tres_ID) REFERENCES Treasure (Tres_ID));

CREATE TABLE Room_Treasure (
  Tres_ID NUMBER,
  Room_ID NUMBER,
  CONSTRAINT PKRoom_Tres PRIMARY KEY(Tres_ID, Room_ID),
  CONSTRAINT FKTres_IDRoom FOREIGN KEY (Tres_ID) REFERENCES Treasure (Tres_ID),
  CONSTRAINT FKRoom_ID FOREIGN KEY (Room_ID) REFERENCES Room (Room_ID));

CREATE SEQUENCE Exp_IDSeq
START WITH 10
INCREMENT BY 1;

CREATE SEQUENCE Tres_IDSeq
START WITH 3332
INCREMENT BY 1;

CREATE SEQUENCE Room_IDSeq
START WITH 4999
INCREMENT BY 1;

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Highway56', 'StartSpace');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Highway56', 'Pathway');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Burgess Ranch', 'Ranch in city');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Towson Ranch', 'Ranch in city');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Highway56', 'Pathway');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Belkin Ranch', 'Ranch in city');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Stanton Ranch', 'Ranch in city');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Highway56', 'Pathway');

INSERT INTO Room
(Room_ID, Name, Descr)
VALUES
(Room_IDSeq.nextval, 'Highway56', 'EndSpace');

INSERT INTO Explorer
(Exp_ID, Name, Username, Max_Item_Count, Max_Bag_Weight, Max_Item_Weight)
VALUES
(Exp_IDSeq.nextval, 'Vasco Da Gama', 'RichyC', 4, 4, 4);

INSERT INTO Explorer
(Exp_ID, Name, Username, Max_Item_Count, Max_Bag_Weight, Max_Item_Weight)
VALUES
(Exp_IDSeq.nextval, 'Neil Armstrong', 'Eduardo', 4, 4, 4);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Nothing', 'No treasure', 0, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Nothing', 'No Treasure', 0, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Bananas', 'A bundle of bananas', 25, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Corn', 'A basket of corn', 25, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Nothing', 'No Treasure', 0, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Rice', 'Rice', 25, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Hay', 'A bundle of hay', 15, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Nothing', 'No treasure', 0, 0);

INSERT INTO Treasure
(Tres_ID, Name, Descr, Value, Weight)
VALUES
(Tres_IDSeq.nextval, 'Nothing', 'No treasure', 0, 0);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3333, 5000);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3334, 5001);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3335, 5002);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3336, 5003);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3337, 5004);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3338, 5005);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3339, 5006);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3340, 5007);

INSERT INTO Room_Treasure
(Tres_ID, Room_ID)
VALUES
(3341, 5008);

