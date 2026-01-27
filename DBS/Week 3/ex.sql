-- 1. Find courses that ran in Fall 2009 or in Spring 2010. Use UNION all to retain duplicates.

SQL> select c.title from course c join takes t on c.course_id = t.course_id where semester='Fall' AND year=2009 UNION ALL (select c.title from course c join takes t on c.course_id = t.course_id where semester='Spring' AND year=2010);

TITLE
--------------------------------------------------
Intro. to Computer Science
Intro. to Computer Science
Intro. to Computer Science
Intro. to Computer Science
Intro. to Computer Science
Intro. to Computer Science
Intro. to Computer Science
Robotics
Robotics
Image Processing
Image Processing

TITLE
--------------------------------------------------
Database System Concepts
Database System Concepts
Investment Banking
World History
Music Video Production
Physical Principles

17 rows selected.

-- 2. Find courses that ran in Fall 2009 and in spring 2010. Use INTERSECT all to retain duplicates.

SQL> select c.title from course c join takes t on c.course_id = t.course_id where semester='Fall' AND year=2009 INTERSECT select c.title from course c join takes t on c.course_id = t.course_id where semester='Spring' AND year=2010;

TITLE
--------------------------------------------------
Intro. to Computer Science

-- 3. Find courses that ran in Fall 2009 but not in Spring 2010. (MINUS)

SQL> select c.title from course c join takes t on c.course_id = t.course_id where semester='Fall' AND year=2009 MINUS select c.title from course c join takes t on c.course_id = t.course_id where semester='Spring' AND year=2010;

TITLE
--------------------------------------------------
Database System Concepts
Physical Principles

-- 4. Find the name of the course for which none of the students registered. (Null values)

SQL> SELECT title FROM course c WHERE NOT EXISTS (SELECT * FROM takes t WHERE t.course_id = c.course_id);

TITLE
--------------------------------------------------
Computational Biology

-- Set Membership (IN / NOT IN).

-- 5. Find courses offered in Fall 2009 and in Spring 2010. Set Membership (IN / NOT IN).

SQL> SELECT course_id FROM takes WHERE semester = 'Fall' AND year = 2009 AND course_id IN (SELECT course_id FROM takes WHERE semester = 'Spring' AND year = 2010);

COURSE_I
--------
CS-101
CS-101
CS-101
CS-101
CS-101
CS-101

6 rows selected.

-- 6. Find the total number of students who have taken course taught by the instructor with ID 10101.

SQL> SELECT COUNT(DISTINCT ID) FROM takes WHERE (course_id) IN (SELECT course_id FROM teaches WHERE ID = '10101');

COUNT(DISTINCTID)
-----------------
                6

-- 7. Find courses offered in Fall 2009 but not in Spring 2010.

SQL> SELECT course_id FROM takes WHERE semester = 'Fall' AND year = 2009 AND course_id NOT IN (SELECT course_id FROM takes WHERE semester = 'Spring' AND year = 2010);

COURSE_I
--------
CS-347
CS-347
PHY-101

-- 8. Find the names of all students whose name is same as the instructor’s name.

SQL> SELECT name FROM student WHERE name IN (SELECT name FROM instructor);

NAME
--------------------
Brandt


-- Set Comparison (>= some/all)
-- 9. Find names of instructors with salary greater than that of some (at least one) instructor in the Biology department.

SQL> SELECT name FROM instructor WHERE salary > SOME(SELECT salary FROM instructor WHERE dept_name = 'Biology');

NAME
--------------------
Einstein
Brandt
Wu
Gold
Kim
Singh
Katz

7 rows selected.

-- 10. Find the names of all instructors whose salary is greater than the salary of all instructors in the Biology department.

SQL> SELECT name FROM instructor WHERE salary > ALL(SELECT salary FROM instructor WHERE dept_name = 'Biology');

NAME
--------------------
Katz
Singh
Kim
Gold
Wu
Brandt
Einstein

7 rows selected.

-- 11. Find the departments that have the highest average salary.

SQL> SELECT dept_name FROM instructor GROUP BY dept_name HAVING AVG(salary) >= ALL (SELECT AVG(salary) FROM instructor GROUP BY dept_name);

DEPT_NAME
--------------------
Physics


-- 12. Find the names of those departments whose budget is lesser than the average salary of all instructors.

SQL> SELECT dept_name FROM department WHERE budget < ( SELECT AVG(salary) FROM instructor);

DEPT_NAME
--------------------
History
Physics

-- Test for empty relation (EXISTS / NOT EXISTS)
-- 13. Find all courses taught in both the Fall 2009 semester and in the Spring 2010 semester

SQL> SELECT DISTINCT(t.course_id) FROM takes t WHERE t.semester = 'Fall' AND t.year = 2009
  2    AND EXISTS (SELECT * FROM takes s WHERE s.course_id = t.course_id AND s.semester = 'Spring' AND s.year = 2010);

COURSE_I
--------
CS-101

-- 14. Find all students who have taken all courses offered in the Biology department.

SQL> SELECT s.name FROM student s JOIN takes t ON s.ID = t.ID WHERE t.course_id IN (SELECT course_id FROM course WHERE dept_name = 'Biology') GROUP BY s.ID, s.name HAVING  COUNT(DISTINCT t.course_id) = (SELECT COUNT(*) FROM course WHERE dept_name = 'Biology');

no rows selected

-- 15. Find all courses that were offered at most once in 2009.

SQL> SELECT course_id FROM teaches WHERE year = 2009 GROUP BY course_id HAVING COUNT(course_id) <= 1;

COURSE_I
--------
CS-101
CS-347
PHY-101
EE-181
BIO-101

-- 16. Find all the students who have opted at least two courses offered by CSE department.

SQL> SELECT s.ID, s.name FROM takes t JOIN student s ON t.id = s.id WHERE t.course_id IN (SELECT course_id FROM course WHERE dept_name = 'Comp. Sci.')
  2  GROUP BY s.ID, s.name HAVING COUNT(DISTINCT course_id) >= 2;

ID    NAME
----- --------------------
45678 Levy
00128 Zhang
98765 Bourikas
12345 Shankar
54321 Williams
76543 Brown

6 rows selected.

-- 17. Find the average instructors salary of those departments where the average salary is greater than 42000. (Subquery in FROM clause)

SQL> SELECT dept_name, avg_salary FROM (SELECT dept_name, AVG(salary) AS avg_salary FROM instructor GROUP BY dept_name) WHERE avg_salary > 42000;

DEPT_NAME            AVG_SALARY
-------------------- ----------
Comp. Sci.           77333.3333
Biology                   72000
History                   61000
Finance                   85000
Elec. Eng.                80000
Physics                   91000

6 rows selected.

-- 18. Create a view all_courses consisting of course sections offered by Physics department in the Fall 2009, with the building and room number of each section.

SQL> CREATE VIEW all_courses AS SELECT
  2      section.course_id,
  3      section.sec_id,
  4      section.building,
  5      section.room_number
  6  FROM section JOIN course ON section.course_id = course.course_id
  7  WHERE
  8      course.dept_name = 'Physics'
  9      AND section.semester = 'Fall'
 10      AND section.year = 2009;

View created.

-- 19. Select all the courses from all_courses view.

SQL> SELECT course_id FROM all_courses;

COURSE_I
--------
PHY-101

-- 20. Create a view department_total_salary consisting of department name and total salary of that department

SQL> CREATE VIEW department_total_salary AS SELECT dept_name, SUM(salary) AS total_salary FROM instructor GROUP BY dept_name;

View created.

SQL> SELECT * FROM department_total_salary;

DEPT_NAME            TOTAL_SALARY
-------------------- ------------
Comp. Sci.                 232000
Biology                     72000
History                    122000
Finance                    170000
Elec. Eng.                  80000
Music                       40000
Physics                    182000

7 rows selected.
