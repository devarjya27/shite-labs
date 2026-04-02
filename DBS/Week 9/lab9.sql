-- 1. Write a procedure to display a message “Good Day to You”.
SQL> ed
Wrote file afiedt.buf

  1  CREATE OR REPLACE PROCEDURE greet AS
  2  BEGIN
  3      DBMS_OUTPUT.PUT_LINE('Good Day to You');
  4* END;
SQL> /

Procedure created.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2  begin
  3  greet;
  4* end;
SQL> /
Good Day to You

PL/SQL procedure successfully completed.

-- 2. Based on the University Database Schema in Lab 2, write a procedure which takes the dept_name as input parameter and lists all the instructors associated with the department as well as list all the courses offered by the department. Also, write an anonymous block with the procedure call.

SQL> ed
Wrote file afiedt.buf

  1  CREATE OR REPLACE PROCEDURE get_dept_details(p_dept_name IN VARCHAR2) AS
  2  BEGIN
  3      DBMS_OUTPUT.PUT_LINE('Instructors:');
  4      FOR r1 IN (SELECT name FROM instructor WHERE dept_name = p_dept_name) LOOP
  5          DBMS_OUTPUT.PUT_LINE(r1.name);
  6      END LOOP;
  7      DBMS_OUTPUT.PUT_LINE('Courses:');
  8      FOR r2 IN (SELECT title FROM course WHERE dept_name = p_dept_name) LOOP
  9          DBMS_OUTPUT.PUT_LINE(r2.title);
 10      END LOOP;
 11* END;
 12  /

Procedure created.

SQL> BEGIN
  2      get_dept_details('Biology');
  3  END;
  4  /
Instructors:
Crick
Courses:
Intro. to Biology
Genetics
Computational Biology

PL/SQL procedure successfully completed.

-- 3. Based on the University Database Schema in Lab 2, write a Pl/Sql block of code that lists the most popular course (highest number of students take it) for each of the departments. It should make use of a procedure course_popular which finds the most popular course in the given department

SQL> ed
Wrote file afiedt.buf

  1  CREATE OR REPLACE PROCEDURE course_popular (
  2      p_dept IN VARCHAR2,
  3      p_course OUT VARCHAR2
  4  ) AS
  5  BEGIN
  6      SELECT title INTO p_course
  7      FROM (
  8          SELECT c.title
  9          FROM course c
 10          JOIN takes t ON c.course_id = t.course_id
 11          WHERE c.dept_name = p_dept
 12          GROUP BY c.title
 13          ORDER BY COUNT(*) DESC
 14      )
 15      WHERE ROWNUM = 1;
 16* END;
 17  /

Procedure created.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      v_popular VARCHAR2(50);
  3  BEGIN
  4      FOR d IN (SELECT dept_name FROM department) LOOP
  5          course_popular(d.dept_name, v_popular);
  6          DBMS_OUTPUT.PUT_LINE(d.dept_name || ': ' || v_popular);
  7      END LOOP;
  8* END;
SQL> /
Biology: Intro. to Biology
Comp. Sci.: Intro. to Computer Science
Elec. Eng.: Intro. to Digital Systems
Finance: Investment Banking
History: World History
Music: Music Video Production
Physics: Physical Principles

PL/SQL procedure successfully completed.

-- 4. Based on the University Database Schema in Lab 2, write a procedure which takes the dept-name as input parameter and lists all the students associated with the department as well as list all the courses offered by the department. Also, write an anonymous block with the procedure call

SQL> ed
Wrote file afiedt.buf

  1  create or replace procedure get_dept_info(p_dept_name student.dept_name%type) as
  2  begin
  3    dbms_output.put_line('Students: ');
  4    for s in (select name from student where dept_name = p_dept_name) loop
  5      dbms_output.put_line(s.name);
  6    end loop;
  7    dbms_output.put_line('Courses: ');
  8    for c in (select title from course where dept_name = p_dept_name) loop
  9      dbms_output.put_line(c.title);
 10    end loop;
 11* end;
 12  /

Procedure created.

SQL> ed
Wrote file afiedt.buf

  1  begin
  2    get_dept_info('Biology');
  3* end;
SQL> /
Students:
Tanaka
Courses:
Intro. to Biology
Genetics
Computational Biology

PL/SQL procedure successfully completed.

-- 5. Write a function to return the Square of a given number and call it from an anonymous block.

SQL> ed
Wrote file afiedt.buf

  1  create or replace function get_square(num in number)
  2  return number as
  3  begin
  4    return num * num;
  5* end;
SQL> /

Function created.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2    result number;
  3  begin
  4    result := get_square(10);
  5    dbms_output.put_line('the square is: ' || result);
  6* end;
SQL> /
the square is: 100

PL/SQL procedure successfully completed.

6. Based on the University Database Schema in Lab 2, write a Pl/Sql block of code that lists the highest paid Instructor in each of the Department. It should make use of a function department_highest which returns the highest paid Instructor for the given branch.

SQL> ed
Wrote file afiedt.buf

  1  create or replace function department_highest(p_dept_name instructor.dept_name%type)
  2  return varchar2 as
  3    v_instructor_name instructor.name%type;
  4  begin
  5    select name into v_instructor_name
  6    from instructor
  7    where dept_name = p_dept_name
  8    and salary = (select max(salary) from instructor where dept_name = p_dept_name)
  9    fetch first 1 row only; -- handles cases where multiple instructors have the same max salary
 10    return v_instructor_name;
 11* end;
 12  /

Function created.

SQL> ed
Wrote file afiedt.buf

  1  begin
  2    for d in (select distinct dept_name from instructor) loop
  3      dbms_output.put_line(d.dept_name || ': ' || department_highest(d.dept_name));
  4    end loop;
  5* end;
SQL> /
Comp. Sci.: Brandt
Biology: Crick
History: Califieri
Finance: Wu
Elec. Eng.: Kim
Music: Mozart
Physics: Einstein

PL/SQL procedure successfully completed.

-- 7.Based on the University Database Schema in Lab 2, create a package to include the following:
a) A named procedure to list the instructor_names of given department
b) A function which returns the max salary for the given department
c) Write a PL/SQL block to demonstrate the usage of above package components

SQL> ed
Wrote file afiedt.buf

  1  create or replace package dept_pkg as
  2    procedure list_instructors(p_dept_name instructor.dept_name%type);
  3    function get_max_salary(p_dept_name instructor.dept_name%type) return number;
  4* end dept_pkg;
SQL> /

Package created.

SQL> ed
Wrote file afiedt.buf

  1  create or replace package body dept_pkg as
  2    procedure list_instructors(p_dept_name instructor.dept_name%type) as
  3    begin
  4      dbms_output.put_line('instructors in ' || p_dept_name || ':');
  5      for i in (select name from instructor where dept_name = p_dept_name) loop
  6        dbms_output.put_line('- ' || i.name);
  7      end loop;
  8    end list_instructors;
  9    function get_max_salary(p_dept_name instructor.dept_name%type) return number as
 10      v_max_sal number;
 11    begin
 12      select max(salary) into v_max_sal
 13      from instructor
 14      where dept_name = p_dept_name;
 15      return v_max_sal;
 16    end get_max_salary;
 17* end dept_pkg;
 18  /

Package body created.


SQL> ed
Wrote file afiedt.buf

  1  declare
  2    v_sal number;
  3    v_dept varchar2(20) := 'Biology';
  4  begin
  5    dept_pkg.list_instructors(v_dept);
  6    v_sal := dept_pkg.get_max_salary(v_dept);
  7    dbms_output.put_line('highest salary in ' || v_dept || ' is: ' || v_sal);
  8* end;
SQL> /
instructors in Biology:
- Crick
highest salary in Biology is: 75600

PL/SQL procedure successfully completed.

-- 8. Write a PL/SQL procedure to return simple and compound interest (OUT parameters) along with the Total Sum (IN OUT) i.e. Sum of Principle and Interest taking as input the principle, rate of interest and number of years (IN parameters). Call this procedure from an anonymous block.

SQL> ed
Wrote file afiedt.buf

  1  create or replace procedure calculate_interest(
  2      p_principle in number,
  3      p_rate in number,
  4      p_years in number,
  5      p_si out number,
  6      p_ci out number,
  7      p_total in out number
  8  ) as
  9  begin
 10      p_si := (p_principle * p_rate * p_years) / 100;
 11      p_ci := p_principle * power((1 + p_rate/100), p_years) - p_principle;
 12      p_total := p_principle + p_si;
 13* end;
 14  /

Procedure created.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2      v_principle number := 1000;
  3      v_rate number := 5;
  4      v_years number := 2;
  5      v_si number;
  6      v_ci number;
  7      v_total number := 0; -- will be updated by the procedure
  8  begin
  9      calculate_interest(v_principle, v_rate, v_years, v_si, v_ci, v_total);
 10      dbms_output.put_line('simple interest: ' || round(v_si, 2));
 11      dbms_output.put_line('compound interest: ' || round(v_ci, 2));
 12      dbms_output.put_line('total sum (p + si): ' || round(v_total, 2));
 13* end;
 14  /
simple interest: 100
compound interest: 102.5
total sum (p + si): 1100

PL/SQL procedure successfully completed.

