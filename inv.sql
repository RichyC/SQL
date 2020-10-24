--
-- Inventory Homework Assignment
-- Create a sequence to generate a purchase order number
-- Create a procedure to buy a single product.
-- Create a trigger to automatically enter a purchase order
-- when the on_hand quantity falls below 5 units.
-- Test all possible scenarios.
--
-- Author: Jeff Pittges
-- Version: 23-Jun-2019
--
SET SERVEROUTPUT ON;
SET ECHO ON;

DROP TABLE Purchase_Orders;
DROP TABLE Products;

DROP SEQUENCE po_seq;
DROP SEQUENCE Prod_seq;

CREATE SEQUENCE po_seq
START WITH 2111
INCREMENT BY 1;

CREATE SEQUENCE Prod_seq
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Products (
	Prod_ID	NUMBER,
	Descr	 VARCHAR2(10),
	In_Stock NUMBER	CHECK(In_Stock >= 0),
	CONSTRAINT PK_PRODUCT PRIMARY KEY(Prod_ID));

CREATE TABLE Purchase_Orders (
	PO_NO	NUMBER,
	Order_Date DATE,
	Prod_ID	NUMBER,
	Qty	NUMBER,
	CONSTRAINT PK_PO PRIMARY KEY(PO_NO),
	CONSTRAINT FK_PRODUCT FOREIGN KEY(Prod_ID) REFERENCES Products);

INSERT INTO Products (Prod_ID, Descr, In_Stock)
	    VALUES (Prod_seq.nextval, 'Jersey', 25, 39.95);

INSERT INTO Products (Prod_ID, Descr, In_Stock)
	    VALUES (Prod_seq.nextval, 'Cap', 42);

INSERT INTO Products (Prod_ID, Descr, In_Stock)
	    VALUES (Prod_seq.nextval, 'Backpack', 12);

INSERT INTO Products
(Prod_ID, Descr, In_Stock)
VALUES
(Prod_seq.nextval, 'Gloves', 5);

INSERT INTO Products
(Prod_ID, Descr, In_Stock)
VALUES
(Prod_seq.nextval, 'Socks', 4);

INSERT INTO Products
(Prod_ID, Descr, In_Stock)
VALUES
(Prod_seq.nextval, 'Shirt', 6);

CREATE OR REPLACE PROCEDURE Buy (
prodID IN Products.Prod_ID%TYPE,
Qty IN Products.In_Stock%TYPE
) IS
-- create variable to compare with quantity being purchased
product_inv NUMBER;
-- create custom exception for insufficient_inventory
insufficient_inventory EXCEPTION;
BEGIN
--set variable to current in_stock quantity of item being purchased
SELECT In_Stock
INTO product_inv
FROM Products
WHERE Prod_ID = prodID;

IF (Qty > product_inv) THEN
RAISE insufficient_inventory;
END IF;

UPDATE Products
SET In_Stock  = In_Stock - Qty
WHERE Prod_ID = prodID;

EXCEPTION
WHEN insufficient_inventory THEN
DBMS_OUTPUT.PUT_LINE('******ERROR: Insufficient inventory to complete purchase.******');
ROLLBACK;
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('There has been an error in your transaction. Please try again.');
ROLLBACK;
END;
/
-- PO_Trig will print 'New Purchase Order Placed' once executed
CREATE OR REPLACE TRIGGER PO_Trig
AFTER UPDATE OF In_Stock
ON Products
FOR EACH ROW
WHEN ((OLD.In_Stock >= 5) AND (NEW.In_Stock < 5))
BEGIN
INSERT INTO Purchase_Orders
(PO_NO, Order_Date, Prod_ID, Qty)
VALUES
(po_seq.nextval, SYSDATE, :OLD.Prod_ID, 10);
DBMS_OUTPUT.PUT_LINE('New Purchase Order Placed');
END;
/

SELECT * FROM Products;

SELECT * FROM Purchase_Orders;
-- procedure will produce an exception because of buying more than in_stock 
EXEC Buy(1001, 45);
-- The following execution should not execute the trigger Because
-- the old quantity is 42 and the new quantity is 41.
EXEC Buy(1001, 1);
-- old quantity is 12 and new in_stock quantity is 4
-- a new purchase ordered will be purchased
EXEC Buy(1002, 8);
-- old quantity is 5 and new in_stock quantiy is 4
-- a new purchase orderd will be purchased
EXEC Buy(1003, 1);
-- old quantity is 4 and new in_stock quantity is 3
EXEC Buy(1004, 1);
-- old quantity is 6 and new in_stocks quantity is 5
EXEC Buy(1005, 1);

