-- 1. Create Employee table with following constraints:
-- • Make EmpNo as Primary key.
-- • Do not allow EmpName, Gender, Salary and Address to have null values.
-- • Allow Gender to have one of the two values: ‘M’, ‘F’.

SQL> CREATE TABLE EMPLOYEE ( EmpNo NUMBER(10) PRIMARY KEY, EmpName VARCHAR(10) NOT NULL, Gender VARCHAR(1) NOT NULL CHECK (GENDER IN ('M','F')), Salary NUMBER(10) NOT NULL, Address VARCHAR(10) NOT NULL, DNo NUMBER(5));

Table created.

-- 2. Create Department table with following:
-- • Make DeptNo as Primary key
-- • Make DeptName as candidate key

SQL> CREATE TABLE Department (DeptNo NUMBER(5) PRIMARY KEY, DeptName VARCHAR(15) NOT NULL UNIQUE, Location VARCHAR(10));

Table created.

-- 3. Make DNo of Employee as foreign key which refers to DeptNo of Department.

SQL> ALTER TABLE Employee ADD CONSTRAINT fk_emp_dept FOREIGN KEY (DNo) REFERENCES Department(DeptNo);

Table altered.

-- 4. Insert few tuples into Employee and Department which satisfies the above constraints.

SQL> INSERT INTO DEPARTMENT VALUES (1, 'Finance', 'New York');

1 row created.

SQL> INSERT INTO DEPARTMENT VALUES (2, 'IT', 'New Jersey');

1 row created.

SQL> INSERT INTO DEPARTMENT VALUES (3, 'HR', 'Delhi');

1 row created.

SQL> INSERT INTO EMPLOYEE VALUES (101, 'John', 'M', 500000, 'New York', 1);

1 row created.

SQL> INSERT INTO EMPLOYEE VALUES (102, 'Alice', 'F', 700000, 'New Jersey', 2);

1 row created.

SQL> INSERT INTO EMPLOYEE VALUES (103, 'Kevin', 'M', 1500000, 'Singapore', 3);

1 row created.

-- 5. Try to insert few tuples into Employee and Department which violates some of the above constraints.

SQL> INSERT INTO EMPLOYEE VALUES (104, 'Juan', 'G', 1500000, 'Delhi', 3);
INSERT INTO EMPLOYEE VALUES (104, 'Juan', 'G', 1500000, 'Delhi', 3)
*
ERROR at line 1:
ORA-02290: check constraint (DS18LAB15.SYS_C0013139) violated


SQL> INSERT INTO EMPLOYEE VALUES (105, 'Robin', 'F', NULL, 'London', 3);
INSERT INTO EMPLOYEE VALUES (105, 'Robin', 'F', NULL, 'London', 3)
                                                *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("DS18LAB15"."EMPLOYEE"."SALARY")


SQL> INSERT INTO EMPLOYEE VALUES (106, 'Blake', 'F', 30000, NULL, 1);
INSERT INTO EMPLOYEE VALUES (106, 'Blake', 'F', 30000, NULL, 1)
                                                       *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("DS18LAB15"."EMPLOYEE"."ADDRESS")

-- 6. Try to modify/delete a tuple which violates a constraint.

SQL> UPDATE EMPLOYEE SET SALARY=NULL WHERE EMPNO=101;
UPDATE EMPLOYEE SET SALARY=NULL WHERE EMPNO=101
                    *
ERROR at line 1:
ORA-01407: cannot update ("DS18LAB15"."EMPLOYEE"."SALARY") to NULL

SQL> UPDATE EMPLOYEE SET SALARY= NULL WHERE DNO = 1;
UPDATE EMPLOYEE SET SALARY= NULL WHERE DNO = 1
                    *
ERROR at line 1:
ORA-01407: cannot update ("DS18LAB15"."EMPLOYEE"."SALARY") to NULL


-- 7. Modify the foreign key constraint of Employee table such that whenever a department tuple is deleted, the employees belonging to that department will also be deleted.


SQL> ALTER TABLE EMPLOYEE DROP CONSTRAINT fk_emp_dept;

Table altered.

SQL> ALTER TABLE Employee ADD CONSTRAINT fk_emp_dept FOREIGN KEY (DNo) REFERENCES Department(DeptNo) ON DELETE CASCADE;

Table altered.

SQL> DELETE FROM DEPARTMENT WHERE DeptNo=3;

1 row deleted.

SQL> SELECT * FROM EMPLOYEE;

     EMPNO EMPNAME    G     SALARY ADDRESS           DNO
---------- ---------- - ---------- ---------- ----------
       101 John       M     500000 New York            1
       102 Alice      F     700000 New Jersey          2

-- 8. Create a named constraint to set the default salary to 10000 and test the constraint by inserting a new record.

SQL> ALTER TABLE EMPLOYEE MODIFY SALARY DEFAULT 10000;

Table altered.

SQL> ALTER TABLE EMPLOYEE ADD CONSTRAINT MIN_SALARY CHECK (SALARY >= 10000);

Table altered.

INSERT INTO EMPLOYEE VALUES (107, 'Robin', 'F', 5000, 'New York', 2);

SQL> INSERT INTO EMPLOYEE VALUES (107, 'Robin', 'F', 5000, 'New York', 2);
INSERT INTO EMPLOYEE VALUES (107, 'Robin', 'F', 5000, 'New York', 2)
*
ERROR at line 1:
ORA-02290: check constraint (DS18LAB15.MIN_SALARYN) violated

-- 24. Insert appropriate DOB values for employees. Display the birth date of all the employees in the following format:
-- • ‘DD-MON-YYYY’
-- • ‘DD-MON-YY’
-- • ‘DD-MM-YY’

SQL> ALTER TABLE employee ADD (DOB DATE);

Table altered.

SQL> UPDATE employee SET DOB = TO_DATE('15-JAN-1990', 'DD-MON-YYYY') WHERE EMPNO = 101;

1 row updated.

SQL> UPDATE employee SET DOB = TO_DATE('23-AUG-1998', 'DD-MON-YYYY') WHERE EMPNO = 102;

1 row updated.

SQL> UPDATE employee SET DOB = TO_DATE('02-DEC-2002', 'DD-MON-YYYY') WHERE EMPNO = 103;

1 row updated.


SQL> SELECT TO_CHAR(DOB, 'DD-MON-YYYY'), TO_CHAR(DOB, 'DD-MON-YY'), TO_CHAR(DOB, 'DD-MM-YY') FROM employee;

TO_CHAR(DOB,'DD-MON- TO_CHAR(DOB,'DD-MO TO_CHAR(
-------------------- ------------------ --------
15-JAN-1990          15-JAN-90          15-01-90
23-AUG-1998          23-AUG-98          23-08-98
02-DEC-2002          02-DEC-02          02-12-02

-- 25. List the employee names and the year (fully spelled out) in which they are born
-- • ‘YEAR’
-- • ‘Year’
-- • ‘year’

SQL> SELECT EMPNAME, TO_CHAR(DOB, 'YEAR'), TO_CHAR(DOB, 'Year'), TO_CHAR(DOB, 'year') FROM employee;

EMPNAME    TO_CHAR(DOB,'YEAR')                        TO_CHAR(DOB,'YEAR')                        TO_CHAR(DOB,'YEAR')
---------- ------------------------------------------ ------------------------------------------ ------------------------------------------
John       NINETEEN NINETY                            Nineteen Ninety                            nineteen ninety
Alice      NINETEEN NINETY-EIGHT                      Nineteen Ninety-Eight                      nineteen ninety-eight
Kevin      TWO THOUSAND TWO                           Two Thousand Two                           two thousand two
