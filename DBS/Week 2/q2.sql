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