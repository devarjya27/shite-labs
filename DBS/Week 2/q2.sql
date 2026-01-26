SQL> @D:/240968040-DBS/LAB2/smallRelationsUniv.sql;


-- 9. List all Students with names and their department names.

SQL> SELECT name, dept_name FROM Student;

NAME                 DEPT_NAME
-------------------- --------------------
Zhang                Comp. Sci.
Shankar              Comp. Sci.
Brandt               History
Chavez               Finance
Peltier              Physics
Levy                 Physics
Williams             Comp. Sci.
Sanchez              Music
Snow                 Physics
Brown                Comp. Sci.
Aoi                  Elec. Eng.

NAME                 DEPT_NAME
-------------------- --------------------
Bourikas             Elec. Eng.
Tanaka               Biology

13 rows selected.


-- 10. List all instructors in CSE department.

SQL> SELECT name FROM instructor WHERE dept_name='Comp. Sci.';

NAME
--------------------
Srinivasan
Katz
Brandt

-- 11. Find the names of courses in CSE department which have 3 credits.

SQL> SELECT title FROM course WHERE (credits=3 AND dept_name='Comp. Sci.');

TITLE
--------------------------------------------------
Robotics
Image Processing
Database System Concepts

-- 12. For the student with ID 12345 (or any other value), show all course-id and title of all courses registered for by the student.


SQL>  SELECT course.course_id, course.title FROM course JOIN takes ON course.course_id = takes.course_id WHERE takes.ID = '12345';

COURSE_I TITLE
-------- --------------------------------------------------
CS-101   Intro. to Computer Science
CS-190   Game Design
CS-315   Robotics
CS-347   Database System Concepts

-- 13. List all the instructors whose salary is in between 40000 and 90000.

SQL> SELECT name FROM instructor WHERE (salary BETWEEN 40000 AND 90000);

NAME
--------------------
Srinivasan
Wu
Mozart
El Said
Gold
Katz
Califieri
Singh
Crick
Kim

10 rows selected.

-- 14. Display the IDs of all instructors who have never taught a course.

SQL> SELECT name FROM instructor WHERE ID NOT IN (SELECT ID FROM teaches);

NAME
--------------------
Singh
Califieri
Gold

-- 15. Find the student names, course names, and the year, for all students those who have attended classes in room-number 303.

SQL> SELECT s.name, c.title, t.year FROM student s JOIN takes t ON s.ID = t.ID JOIN course c ON t.course_id = c.course_id JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id AND t.semester = sec.semester AND t.year = sec.year WHERE sec.room_number = '303';

no rows selected

-- 16. For all students who have opted courses in 2015, find their names and course idâ€™s with the attribute course title replaced by c-name.

SQL> SELECT s.name, t.course_id, c.title AS 'c_name' FROM student s JOIN takes t ON s.ID = t.ID JOIN course c ON t.course_id = c.course_id WHERE t.year = 2015;

no rows selected


-- 17. Find the names of all instructors whose salary is greater than the salary of at least one instructor of CSE department and salary replaced by inst-salary.

SQL> SELECT name, salary AS inst_salary FROM instructor WHERE salary > SOME(SELECT salary FROM instructor WHERE dept_name = 'Comp. Sci.');

NAME                 INST_SALARY
-------------------- -----------
Einstein                   95000
Brandt                     92000
Wu                         90000
Gold                       87000
Kim                        80000
Singh                      80000
Katz                       75000
Crick                      72000

8 rows selected.

-- 18. Find the names of all instructors whose department name includes the substring â€˜châ€™.

SQL> SELECT name FROM instructor WHERE name LIKE '%ch%';

no rows selected

-- 19. List the student names along with the length of the student names.

SQL> SELECT name, LENGTH(name) FROM student;

NAME                 LENGTH(NAME)
-------------------- ------------
Zhang                           5
Shankar                         7
Brandt                          6
Chavez                          6
Peltier                         7
Levy                            4
Williams                        8
Sanchez                         7
Snow                            4
Brown                           5
Aoi                             3

NAME                 LENGTH(NAME)
-------------------- ------------
Bourikas                        8
Tanaka                          6

13 rows selected.

-- 20. List the department names and 3 characters from 3rd position of each department name

SQL> SELECT dept_name, SUBSTR(dept_name,3,3) FROM Department;

DEPT_NAME            SUBSTR(DEPT_
-------------------- ------------
Biology              olo
Comp. Sci.           mp.
Elec. Eng.           ec.
Finance              nan
History              sto
Music                sic
Physics              ysi

7 rows selected.

-- 21. List the instructor names in upper case.

SQL> SELECT UPPER(name) From Instructor;

UPPER(NAME)
--------------------
SRINIVASAN
WU
MOZART
EINSTEIN
EL SAID
GOLD
KATZ
CALIFIERI
SINGH
CRICK
BRANDT

UPPER(NAME)
--------------------
KIM

12 rows selected.

-- 22. Replace NULL with value1(say 0) for a column in any of the table

SQL> SELECT name, NVL(ID,0) FROM Instructor;

NAME                 NVL(I
-------------------- -----
Srinivasan           10101
Wu                   12121
Mozart               15151
Einstein             22222
El Said              32343
Gold                 33456
Katz                 45565
Califieri            58583
Singh                76543
Crick                76766
Brandt               83821

NAME                 NVL(I
-------------------- -----
Kim                  98345

12 rows selected.

-- 23. Display the salary and salary/3 rounded to nearest hundred from Instructor.

SELECT salary, ROUND(salary / 3, -2) FROM Instructor;

QL> SELECT salary, ROUND(salary / 3, -2) FROM Instructor;

    SALARY ROUND(SALARY/3,-2)
---------- ------------------
     65000              21700
     90000              30000
     40000              13300
     95000              31700
     60000              20000
     87000              29000
     75000              25000
     62000              20700
     80000              26700
     72000              24000
     92000              30700

    SALARY ROUND(SALARY/3,-2)
---------- ------------------
     80000              26700

12 rows selected.
