-- 1. Retrieve the birth date and address of the employee(s) whose name is ‘John B. Smith’. Retrieve the name and address of all employees who work for the ‘Research’ department.

SQL> select bdate, address from employee where fname='John' AND MINIT='B' AND lname='Smith';

BDATE     ADDRESS
--------- ------------------------------
09-JAN-65 731 Fondren, Houston, TX

SQL> select e.fname, e.minit, e.lname, e.address from employee e join department d on e.dno = d.dnumber where d.dname='Research';

FNAME           M LNAME           ADDRESS
--------------- - --------------- ------------------------------
John            B Smith           731 Fondren, Houston, TX
Franklin        T Wong            638 Voss, Houston, TX
Ramesh          K Narayan         975 Fire Oak, Humble, TX
Joyce           A English         5631 Rice, Houston, TX

-- 2. For every project located in ‘Stafford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date.

SQL> select p.pnumber, d.dnumber, e.lname, e.address, e.bdate from project p join department d on p.dnum = d.dnumber join employee e on e.ssn = d.mgr_ssn where p.plocation = 'Stafford';

   PNUMBER    DNUMBER LNAME           ADDRESS                        BDATE
---------- ---------- --------------- ------------------------------ ---------
        10          4 Wallace         291 Berry, Bellaire, TX        20-JUN-41

-- 3. For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor.

SQL> select e.fname, e.lname, s.fname as super_fname, s.lname as super_lname from employee e join employee s on e.ssn = s.super_ssn;

FNAME           LNAME           SUPER_FNAME     SUPER_LNAME
--------------- --------------- --------------- ---------------
Richard         Marini          Richard         Marini
Franklin        Wong            John            Smith
James           Borg            Franklin        Wong
Jennifer        Wallace         Alicia          Zelaya
James           Borg            Jennifer        Wallace
Franklin        Wong            Ramesh          Narayan
Franklin        Wong            Joyce           English
Jennifer        Wallace         Ahmad           Jabbar

8 rows selected.

-- 4. Make a list of all project numbers for projects that involve an employee whose last name is ‘Smith’, either as a worker or as a manager of the department that controls the project.

SQL> SELECT p.pnumber FROM project p JOIN works_on w ON p.pnumber = w.pno JOIN employee e ON w.essn = e.ssn WHERE e.lname = 'Smith'
  2  UNION
  3  SELECT p.pnumber FROM project p JOIN department d ON p.dnum = d.dnumber JOIN employee e ON d.mgr_ssn = e.ssn WHERE e.lname = 'Smith';

   PNUMBER
----------
         1
         2

-- 5. Show the resulting salaries if every employee working on the ‘ProductX’ project is given a 10 percent raise.

SQL> select e.salary * 1.1 from employee e join works_on w on w.essn = e.ssn join project p on w.pno = p.pnumber where p.pname = 'ProductX';

E.SALARY*1.1
------------
       33000
       27500

-- 6. Retrieve a list of employees and the projects they are working on, ordered by department and, within each department, ordered alphabetically by last name, then first name.

SQL> select e.fname, e.minit, e.lname, d.dname, p.pname from employee e join works_on w on w.essn = e.ssn join project p on w.pno = p.pnumber join department d on e.dno = d.dnumber order by d.dname, e.lname, e.fname;

FNAME           M LNAME           DNAME           PNAME
--------------- - --------------- --------------- ---------------
James           E Borg            Administration  Reorganization
Ahmad           V Jabbar          Administration  Computerization
Ahmad           V Jabbar          Administration  Newbenefits
Jennifer        S Wallace         Administration  Newbenefits
Jennifer        S Wallace         Administration  Reorganization
Alicia          J Zelaya          Administration  Newbenefits
Alicia          J Zelaya          Administration  Computerization
Joyce           A English         Research        ProductY
Joyce           A English         Research        ProductX
Ramesh          K Narayan         Research        ProductZ
John            B Smith           Research        ProductY

FNAME           M LNAME           DNAME           PNAME
--------------- - --------------- --------------- ---------------
John            B Smith           Research        ProductX
Franklin        T Wong            Research        Reorganization
Franklin        T Wong            Research        ProductZ
Franklin        T Wong            Research        ProductY
Franklin        T Wong            Research        Computerization

16 rows selected.

-- 7. Retrieve the name of each employee who has a dependent with the same first name and is the same sex as the employee.

SQL> INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship) VALUES ('123456789', 'John', 'M', '01-DEC-99', 'Son');

1 row created.

SQL> select e.fname from employee e join dependent d on d.essn = e.ssn where d.dependent_name = e.fname and e.sex = d.sex;

FNAME
---------------
John

-- 8. Retrieve the names of employees who have no dependents.

SQL> select e.fname, e.lname from employee e where not exists (select * from dependent d where d.essn = e.ssn);

FNAME           LNAME
--------------- ---------------
Richard         Marini
James           Borg
Alicia          Zelaya
Ahmad           Jabbar
Joyce           English
Ramesh          Narayan

6 rows selected.

-- 9. List the names of managers who have at least one dependent

SQL> select e.fname, e.lname from employee e join department d ON e.ssn = d.mgr_ssn join dependent dep ON e.ssn = dep.essn;

FNAME           LNAME
--------------- ---------------
Franklin        Wong
Franklin        Wong
Franklin        Wong
Jennifer        Wallace

-- 10. Find the sum of the salaries of all employees, the maximum salary, the minimum salary, and the average salary

SQL> SELECT SUM(salary), MAX(salary), MIN(salary), AVG(salary) from employee;

SUM(SALARY) MAX(SALARY) MIN(SALARY) AVG(SALARY)
----------- ----------- ----------- -----------
     318000       55000       25000  35333.3333

-- 11. For each project, retrieve the project number, the project name, and the number of employees who work on that project

SQL> select p.pnumber, p.pname, count(w.essn) from project p join works_on w on p.pnumber = w.pno group by p.pnumber, p.pname;

   PNUMBER PNAME           COUNT(W.ESSN)
---------- --------------- -------------
         2 ProductY                    3
        30 Newbenefits                 3
        20 Reorganization              3
         1 ProductX                    2
        10 Computerization             3
         3 ProductZ                    2

6 rows selected.

-- 12. For each project on which more than two employees work, retrieve the project number, the project name, and the number of employees who work on the project

SQL> select p.pnumber, p.pname, count(w.essn) from project p join works_on w on p.pnumber = w.pno group by p.pnumber, p.pname having count(w.essn) > 2;

   PNUMBER PNAME           COUNT(W.ESSN)
---------- --------------- -------------
         2 ProductY                    3
        30 Newbenefits                 3
        20 Reorganization              3
        10 Computerization             3

-- 13. For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than 40,000.

SQL> INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, super_ssn, dno)
  2  VALUES ('Robert', 'A', 'Miller', '111223333', '12-MAY-80', '123 Maple, Katy, TX', 'M', 45000, '888665555', 4);

1 row created.

SQL> select dno, count(*) from employee where salary > 40000 and dno IN (select dno from employee group by dno having count(*) > 5) group by dno;

       DNO   COUNT(*)
---------- ----------
         4          3