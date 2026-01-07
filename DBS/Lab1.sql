-- 1. Create a table employee with (emp_no, emp_name, emp_address)

SQL> CREATE TABLE EMPLOYEE (EMP_NO NUMBER(10) PRIMARY KEY, EMP_NAME VARCHAR(20), EMP_ADDRESS VARCHAR(30));

Table created.

-- 2. Insert five employees information.

SQL> INSERT INTO EMPLOYEE VALUES (101, 'AAA', 'Uttar Pradesh');

1 row created.

SQL> INSERT INTO EMPLOYEE VALUES (102, 'BBB', 'Faridabad');

1 row created.

SQL> INSERT INTO EMPLOYEE VALUES (103, 'CCC', 'Mangalore');

1 row created.

SQL> INSERT INTO EMPLOYEE VALUES (104, 'DDD', 'Manipal');

1 row created.

SQL> INSERT INTO EMPLOYEE VALUES (105, 'EEE', 'Assam');

1 row created.


-- 3. Display names of all employees.

SQL> SELECT EMP_NAME FROM EMPLOYEE;

EMP_NAME
---
AAA
BBB
CCC
DDD
EEE


-- 4. Display all the employees from 'Manipal'.

SQL> SELECT * FROM EMPLOYEE WHERE EMP_ADDRESS='Manipal';

    EMP_NO EMP_NAME             EMP_ADDRESS
---
       104 DDD                  Manipal


-- 5. Add a column named salary to employee table.

SQL> ALTER TABLE EMPLOYEE ADD(SALARY NUMBER(10));

Table altered.


-- 6. Assign the salary for all employees.

SQL> UPDATE EMPLOYEE SET SALARY='500000' WHERE EMP_NO=101;

1 row updated.

SQL> UPDATE EMPLOYEE SET SALARY='1500000' WHERE EMP_NO=102;

1 row updated.

SQL> UPDATE EMPLOYEE SET SALARY='200000' WHERE EMP_NO=103;

1 row updated.

SQL> UPDATE EMPLOYEE SET SALARY='700000' WHERE EMP_NO=104;

1 row updated.

SQL> UPDATE EMPLOYEE SET SALARY='400000' WHERE EMP_NO=105;

1 row updated.


-- 7. View the structure of the table employee using describe.

SQL> DESC EMPLOYEE
 Name                    Null?    Type
 ----------------------- -------- ----------------
 EMP_NO                  NOT NULL NUMBER(10)
 EMP_NAME                         VARCHAR2(20)
 EMP_ADDRESS                      VARCHAR2(30)
 SALARY                           NUMBER(10)


-- 8. Delete all employees from 'Mangalore'.

SQL> DELETE FROM EMPLOYEE WHERE EMP_ADDRESS='Mangalore';

1 row deleted.


-- 9. Rename EMPLOYEE as EMPLOYEE1.

SQL> RENAME EMPLOYEE TO EMPLOYEE1;

Table renamed.


-- 10. Drop the table EMPLOYEE1.

SQL> DROP TABLE EMPLOYEE1;

Table dropped.


