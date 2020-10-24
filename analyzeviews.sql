set timing on

--Drop Views to create new ones
DROP VIEW Parts_Log;

DROP MATERIALIZED VIEW Parts_Mat;

-- Create Logical View
CREATE VIEW Parts_Log AS                                                   
SELECT PARTNO, QTY, PRICE
FROM ABC.sodetail
GROUP BY PARTNO;

-- Create Materialized View
CREATE MATERIALIZED VIEW Parts_Mat AS
SELECT PARTNO, QTY, PRICE
FROM ABC.sodetail
GROUP BY PARTNO;

--execute retrieve statements
SELECT * FROM Parts_Log;

SELECT * FROM Parts_Mat;

--Answers to HW Questions

/* 1.Are the elapsed times for creating a logical view and 
materialized vew different? Explain why or why not.

As a computer scientist, I decided to run three trials. 
My results are as follows and numbered through each trial run

1. View: 00: 00: 00.01
   Materialized View: 00: 00: 00.11

2, View: 00: 00: 00.01
   Materialized View: 00:00:00.12

3. View: 00:00:00.01
   Materialized View: 00:00:00.11

As you can see, the logical view always elapsed less time to create 
than the materialized view. These results can be explained
through the nature of each creation. A logical view requires only 
the storage of the query itself because the logical view acts
as a virtual table and does not require the same process as a materialized
view. A materialized view differs because it requires the 
use of disk space. A materialized view goes beyond being a virtual
table and actually makes a physical copy of the base table's data
to store into another area of the disk as well.
The process of a materialized view creation involves more steps
and therefore explains why a materialized view creation 
elapsed more time than a logical view creation. 

2. Are the elapsed times for querying each view different? Explain why or
why not.

I repeated the three trial process and received the following results:

1. View: 00:00:06.99
   Materialized View: 00:00:07.13

2. View: 00:00:07.21
   Materialized View: 00:00:07.31

3. View: 00:00:06.83
   Materialized Viw: 00:00:07.00

I did not expect the logical view to have faster query timing. Theoritically,
I believe the Materialized View should have less elapsed time in this situation,
but I cannot ignore the evidence provided by the trial runs. 
I have developed a few theories as to why the results provided occurred.

1. The materialized view requires a search in a different area of memory a
and the query modification process is being used by the logical 
view instead of two queries. 

2. An error by the sqlplus program

3. The view queries represents a simple enough query to 
where the difference it makes in query response time is
negligible. 

Please let me know if I am thinking incorrectly and why. */
