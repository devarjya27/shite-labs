-- 1. Write a PL/SQL block to display the GPA of given student.
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  roll number:=&roll;
  3  sgpa number;
  4  begin
  5  select gpa into sgpa from StudentTable where RollNo = roll;
  6  dbms_output.put_line('The GPA for student ' || roll || ' is: ' || sgpa);
  7* end;
  8  /
Enter value for roll: 3
old   2: roll number:=&roll;
new   2: roll number:=3;
The GPA for student 3 is: 3.4

PL/SQL procedure successfully completed.

SQL> /
Enter value for roll: 2
old   2: roll number:=&roll;
new   2: roll number:=2;
The GPA for student 2 is: 6.5

PL/SQL procedure successfully completed.


-- 2. Write a PL/SQL block to display the letter grade(0-4: F; 4-5: E; 5-6: D; 6-7: C; 7-8: B; 8-9: A; 9-10: A+} of given student.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2  roll number:=&roll;
  3  sgpa number;
  4  grade varchar(2);
  5  begin
  6  select gpa into sgpa from StudentTable where RollNo = roll;
  7  if sgpa >= 0 and sgpa < 4 then
  8  grade:='F';
  9  elsif sgpa >= 4 and sgpa < 5 then
 10  grade:='E';
 11  elsif sgpa >= 5 and sgpa < 6 then
 12  grade:='D';
 13  elsif sgpa >= 6 and sgpa < 7 then
 14  grade:='C';
 15  elsif sgpa >= 7 and sgpa < 8 then
 16  grade:='B';
 17  elsif sgpa >= 8 and sgpa < 9 then
 18  grade:='A';
 19  elsif sgpa >= 9 and sgpa <= 10 then
 20  grade:='A+';
 21  end if;
 22  dbms_output.put_line('The grade for student ' || roll || ' is: ' || grade);
 23* end;
SQL> /
Enter value for roll: 2
old   2: roll number:=&roll;
new   2: roll number:=2;
The grade for student 2 is: C

PL/SQL procedure successfully completed.

-- 3. Input the date of issue and date of return for a book. Calculate and display the fine with the appropriate message using a PL/SQL block.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      issue_date  DATE := TO_DATE('&issue_date', 'DD-MON-YYYY');
  3      return_date DATE := TO_DATE('&return_date', 'DD-MON-YYYY');
  4      days_diff   NUMBER;
  5      fine        NUMBER := 0;
  6  BEGIN
  7      days_diff := return_date - issue_date;
  8      IF days_diff <= 7 THEN
  9          fine := 0;
 10          DBMS_OUTPUT.PUT_LINE('Fine: '|| fine);
 11      ELSIF days_diff >= 8 AND days_diff <= 15 THEN
 12          fine := (days_diff - 7) * 1;
 13          DBMS_OUTPUT.PUT_LINE('Fine: ' || fine);
 14      ELSIF days_diff >= 16 AND days_diff <= 30 THEN
 15          fine := (8 * 1) + ((days_diff - 15) * 2);
 16          DBMS_OUTPUT.PUT_LINE('Fine ' || fine);
 17      ELSE
 18          fine := 5.00;
 19          DBMS_OUTPUT.PUT_LINE('Fine: '|| fine);
 20      END IF;
 21      DBMS_OUTPUT.PUT_LINE('Total days held: ' || days_diff);
 22* END;
SQL> /
Enter value for issue_date: 11-JAN-2026
old   2:     issue_date  DATE := TO_DATE('&issue_date', 'DD-MON-YYYY');
new   2:     issue_date  DATE := TO_DATE('11-JAN-2026', 'DD-MON-YYYY');
Enter value for return_date: 31-JAN-2026
old   3:     return_date DATE := TO_DATE('&return_date', 'DD-MON-YYYY');
new   3:     return_date DATE := TO_DATE('31-JAN-2026', 'DD-MON-YYYY');
Fine 18
Total days held: 20

PL/SQL procedure successfully completed.

-- 4. Write a PL/SQL block to print the letter grade of all the students(RollNo: 1 - 5).

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      sgpa  NUMBER;
  3      grade VARCHAR2(2);
  4  BEGIN
  5  For roll IN 1..5 LOOP
  6  SELECT gpa INTO sgpa FROM StudentTable WHERE RollNo = roll;
  7  IF sgpa >= 0 AND sgpa < 4 THEN
  8  grade := 'F';
  9  ELSIF sgpa >= 4 AND sgpa < 5 THEN
 10  grade := 'E';
 11  ELSIF sgpa >= 5 AND sgpa < 6 THEN
 12  grade := 'D';
 13  ELSIF sgpa >= 6 AND sgpa < 7 THEN
 14  grade := 'C';
 15  ELSIF sgpa >= 7 AND sgpa < 8 THEN
 16  grade := 'B';
 17  ELSIF sgpa >= 8 AND sgpa < 9 THEN
 18  grade := 'A';
 19  ELSIF sgpa >= 9 AND sgpa <= 10 THEN
 20  grade := 'A+';
 21  END IF;
 22  DBMS_OUTPUT.PUT_LINE('Roll No: ' || roll || ' | GPA: ' || sgpa || ' | Grade: ' || grade);
 23  END LOOP;
 24* END;
SQL> /
Roll No: 1 | GPA: 5.8 | Grade: D
Roll No: 2 | GPA: 6.5 | Grade: C
Roll No: 3 | GPA: 3.4 | Grade: F
Roll No: 4 | GPA: 7.8 | Grade: B
Roll No: 5 | GPA: 9.5 | Grade: A+

PL/SQL procedure successfully completed.

-- 5. Alter StudentTable by appending an additional column LetterGrade Varchar2(2). Then write a PL/SQL block to update the table with letter grade of each student.

SQL> ALTER TABLE StudentTable ADD LetterGrade VARCHAR2(2);

Table altered.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      roll  NUMBER := 1;
  3      sgpa  NUMBER;
  4      grade VARCHAR2(2);
  5  BEGIN
  6      WHILE roll <= 5 LOOP
  7      SELECT gpa INTO sgpa FROM StudentTable WHERE RollNo = roll;
  8          IF sgpa >= 0 AND sgpa < 4 THEN
  9              grade := 'F';
 10          ELSIF sgpa >= 4 AND sgpa < 5 THEN
 11              grade := 'E';
 12          ELSIF sgpa >= 5 AND sgpa < 6 THEN
 13              grade := 'D';
 14          ELSIF sgpa >= 6 AND sgpa < 7 THEN
 15              grade := 'C';
 16          ELSIF sgpa >= 7 AND sgpa < 8 THEN
 17              grade := 'B';
 18          ELSIF sgpa >= 8 AND sgpa < 9 THEN
 19              grade := 'A';
 20          ELSIF sgpa >= 9 AND sgpa <= 10 THEN
 21              grade := 'A+';
 22          ELSE
 23              grade := NULL;
 24          END IF;
 25          UPDATE StudentTable SET LetterGrade = grade WHERE RollNo = roll;
 26          roll := roll + 1;
 27      END LOOP;
 28* END;
SQL> /

PL/SQL procedure successfully completed.

SQL> SELECT Lettergrade from studenttable;

LE
--
D
C
F
B
A+

-- 6. Write a PL/SQL block to find the student with max. GPA without using aggregate function.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2    max_gpa number := -1;
  3    max_roll number;
  4    curr_gpa number;
  5    last_roll number;
  6  begin
  7    select max(rollno) into last_roll from studenttable;
  8    for i in 1..last_roll loop
  9      begin
 10        select gpa into curr_gpa from studenttable where rollno = i;
 11        if curr_gpa > max_gpa then
 12          max_gpa := curr_gpa;
 13          max_roll := i;
 14        end if;
 15      end;
 16    end loop;
 17    dbms_output.put_line('roll no: ' || max_roll || ' max gpa: ' || max_gpa);
 18* end;
SQL> /
roll no: 5 max gpa: 9.5

PL/SQL procedure successfully completed.

-- 7. Implement lab exercise 4 using GOTO.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2    roll number := 1;
  3    gpa number;
  4    grade varchar2(2);
  5  begin
  6    <<grade_loop>>
  7    select gpa into gpa from studenttable where rollno = roll;
  8    if gpa >= 9 then grade := 'A+';
  9    elsif gpa >= 8 then grade := 'A';
 10    elsif gpa >= 7 then grade := 'B';
 11    elsif gpa >= 6 then grade := 'C';
 12    elsif gpa >= 5 then grade := 'D';
 13    elsif gpa >= 4 then grade := 'E';
 14    else grade := 'F';
 15    end if;
 16    dbms_output.put_line('roll: ' || roll || ' grade: ' || grade);
 17    roll := roll + 1;
 18    if roll <= 5 then
 19      goto grade_loop;
 20    end if;
 21* end;
 22  /
roll: 1 grade: D
roll: 2 grade: C
roll: 3 grade: F
roll: 4 grade: B
roll: 5 grade: A+

PL/SQL procedure successfully completed.

-- 8. Based on the University database schema, write a PL/SQL block to display the details of the Instructor whose name is supplied by the user. Use exceptions to show appropriate error message for the following cases: a. Multiple instructors with the same name b. No instructor for the given name

SQL> ed
Wrote file afiedt.buf

  1  declare
  2    name_in varchar2(50) := '&name';
  3    id_out varchar2(10);
  4    dept_out varchar2(20);
  5    salary_out number;
  6  begin
  7    select id, dept_name, salary into id_out, dept_out, salary_out from instructor where name = name_in;
  8    dbms_output.put_line('id: ' || id_out);
  9    dbms_output.put_line('name: ' || name_in);
 10    dbms_output.put_line('dept: ' || dept_out);
 11    dbms_output.put_line('salary: ' || salary_out);
 12  exception
 13    when no_data_found then
 14      dbms_output.put_line('No instructor found with that name');
 15    when too_many_rows then
 16      dbms_output.put_line('Multiple instructors found with that name');
 17* end;
 18  /
Enter value for name: Srinivasan
old   2:   name_in varchar2(50) := '&name';
new   2:   name_in varchar2(50) := 'Srinivasan';
id: 10101
name: Srinivasan
dept: Comp. Sci.
salary: 65000

PL/SQL procedure successfully completed.