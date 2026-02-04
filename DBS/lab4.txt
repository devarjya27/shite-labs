-- 1. Find the number of students in each course.

SQL> select course_id, count(*) from student join takes on student.id = takes.id group by takes.course_id;

COURSE_I   COUNT(*)
-------- ----------
FIN-201           1
CS-190            2
MU-199            1
CS-101            7
HIS-351           1
CS-319            2
CS-347            2
PHY-101           1
EE-181            1
CS-315            2
BIO-101           1

COURSE_I   COUNT(*)
-------- ----------
BIO-301           1

12 rows selected.


-- 2. Find those departments where the average number of students are greater than 10.

SQL> select dept_name, avg(num_students) from (select dept_name, count(id) as num_students from student group by dept_name) group by dept_name having avg(num_students) > 10;

no rows selected

-- 3. Find the total number of courses in each department.

SQL> select dept_name, count(*) from course group by dept_name;

DEPT_NAME              COUNT(*)
-------------------- ----------
Comp. Sci.                    5
Biology                       3
History                       1
Elec. Eng.                    1
Finance                       1
Music                         1
Physics                       1

7 rows selected.

-- 4. Find the names and average salaries of all departments whose average salary is greater than 42000.

SQL> select dept_name, avg(salary) from instructor group by dept_name having avg(salary) > 42000;

DEPT_NAME            AVG(SALARY)
-------------------- -----------
Comp. Sci.            77333.3333
Biology                    72000
History                    61000
Finance                    85000
Elec. Eng.                 80000
Physics                    91000

6 rows selected.

-- 5. Find the enrolment of each section that was offered in Spring 2009.

SQL> select count(*) as enrollment_id, sec_id from takes where year=2009 and semester='Spring' group by sec_id;

ENROLLMENT_ID SEC_ID
------------- --------
            2 2
            1 1

-- Ordering the display of Tuples (Use ORDER BY ASC/DESC):

-- 6. List all the courses with prerequisite courses, then display course id in increasing order.

SQL> select prereq.course_id, prereq.prereq_id from course join prereq on course.course_id = prereq.prereq_id ORDER BY prereq.course_id;

COURSE_I PREREQ_I
-------- --------
BIO-301  BIO-101
BIO-399  BIO-101
CS-190   CS-101
CS-315   CS-101
CS-319   CS-101
CS-347   CS-101
EE-181   PHY-101

7 rows selected.

-- 7. Display the details of instructors sorting the salary in decreasing order.

SQL> select * from instructor order by salary desc;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
22222 Einstein             Physics                   95000
83821 Brandt               Comp. Sci.                92000
12121 Wu                   Finance                   90000
33456 Gold                 Physics                   87000
98345 Kim                  Elec. Eng.                80000
76543 Singh                Finance                   80000
45565 Katz                 Comp. Sci.                75000
76766 Crick                Biology                   72000
10101 Srinivasan           Comp. Sci.                65000
58583 Califieri            History                   62000
32343 El Said              History                   60000

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
15151 Mozart               Music                     40000

12 rows selected.


-- 8. Find the maximum total salary across the departments.

SQL> select max(tot_salary) from (select sum(salary) as tot_salary from instructor group by dept_name);

MAX(TOT_SALARY)
---------------
         232000


-- 9. Find the average instructors’ salaries of those departments where the average salary is greater than 42000.

SQL> SELECT AVG(salary) FROM instructor GROUP BY dept_name HAVING AVG(salary) > 42000;

AVG(SALARY)
-----------
 77333.3333
      72000
      61000
      85000
      80000
      91000

6 rows selected.

-- 10. Find the sections that had the maximum enrolment in Spring 2010.

SQL> Select max(enrollment) from (select count(*) as enrollment, sec_id from takes where year=2010 and semester='Spring' group by sec_id);

MAX(ENROLLMENT)
---------------
              7

-- 11. Find the names of all instructors who teach all students that belong to ‘CSE’ department.

SELECT name FROM instructor i WHERE NOT EXISTS (
    (SELECT s.ID 
     FROM student s 
     WHERE s.dept_name = 'Comp. Sci.')
    MINUS
    (SELECT tk.ID
     FROM takes tk, teaches tch
     WHERE tk.course_id = tch.course_id
       AND tk.sec_id = tch.sec_id
       AND tk.semester = tch.semester
       AND tk.year = tch.year
       AND tch.ID = i.ID));

-- 12. Find the average salary of those department where the average salary is greater than 50000 and total number of instructors in the department are more than 5.

SQL> select dept_name, avg(salary) as avg_salary from instructor group by dept_name having avg(salary) > 10000 and count(id) > 5;

no rows selected

-- 13. Find all departments with the maximum budget

SQL> WITH max_budget(value) AS (SELECT MAX(budget) FROM department d) SELECT d.dept_name, d.budget FROM department d, max_budget WHERE d.budget = max_budget.value;

DEPT_NAME                BUDGET
-------------------- ----------
Finance                  120000

-- 14. Find all departments where the total salary is greater than the average of the total salary at all departments.

SQL> WITH dept_total AS (SELECT dept_name, SUM(salary) AS total_salary FROM instructor GROUP BY dept_name)
  2  SELECT dept_name FROM dept_total WHERE total_salary > (SELECT AVG(total_salary) FROM dept_total);

DEPT_NAME
--------------------
Physics
Finance
Comp. Sci.
