-- 1. The HRD manager has decided to raise the salary of all the Instructors in a given department number by 5%. Whenever, any such raise is given to the instructor, a record for the same is maintained in the salary_raise table. It includes the Instuctor Id, the date when the raise was given and the actual raise amount. Write a PL/SQL block to update the salary of each Instructor and insert a record in the salary_raise table.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2  i_dept_name varchar2(20) := '&dept_name';
  3  i_id varchar2(5);
  4  sal number;
  5  i_raise number;
  6  cursor c is select id, salary from instructor where dept_name = i_dept_name;
  7  BEGIN
  8  open c;
  9  loop
 10  fetch c into i_id, sal;
 11  exit when c%NOTFOUND;
 12  i_raise := sal * 0.05;
 13  update instructor
 14  set salary = salary + i_raise
 15  where id = i_id;
 16  insert into salary_raise (Instructor_Id, Raise_date, Raise_amt)
 17  values (i_id, sysdate, i_raise);
 18  end loop;
 19  dbms_output.put_line(c%ROWCOUNT || ' instructors updated.');
 20  close c;
 21  commit;
 22* END;
SQL> /
Enter value for dept_name: Biology
old   2: i_dept_name varchar2(20) := '&dept_name';
new   2: i_dept_name varchar2(20) := 'Biology';

PL/SQL procedure successfully completed.

SQL> select * from salary_raise;

INSTR RAISE_DAT  RAISE_AMT
----- --------- ----------
76766 17-MAR-26       3600


-- 2. Write a PL/SQL block that will display the ID, name, dept_name and tot_cred of the first 10 students with lowest total credit

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      s_id   varchar2(5);
  3      s_name varchar2(20);
  4      s_dept varchar2(20);
  5      s_cred number;
  6      s_cnt  number := 0;
  7      cursor c is
  8          select id, name, dept_name, tot_cred
  9          from student
 10          order by tot_cred asc;
 11  BEGIN
 12      open c;
 13      loop
 14          fetch c into s_id, s_name, s_dept, s_cred;
 15          exit when c%NOTFOUND or s_cnt = 10;
 16          dbms_output.put_line('  id: ' ||s_id || ' name: ' || s_name || ' dept: ' || s_dept || ' credits: ' || s_cred);
 17          s_cnt := s_cnt + 1;
 18      end loop;
 19      close c;
 20* END;
SQL> /
id: 70557 name: Snow dept: Physics credits: 0
id: 12345 name: Shankar dept: Comp. Sci. credits: 32
id: 55739 name: Sanchez dept: Music credits: 38
id: 45678 name: Levy dept: Physics credits: 46
id: 54321 name: Williams dept: Comp. Sci. credits: 54
id: 44553 name: Peltier dept: Physics credits: 56
id: 76543 name: Brown dept: Comp. Sci. credits: 58
id: 76653 name: Aoi dept: Elec. Eng. credits: 60
id: 19991 name: Brandt dept: History credits: 80
id: 98765 name: Bourikas dept: Elec. Eng. credits: 98

PL/SQL procedure successfully completed.

-- 3. Print the Course details and the total number of students registered for each course along with the course details - (Course-id, title, dept-name, credits, instructor_name, building, room-number, time-slot-id, tot_student_no )

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      s_cid    varchar2(8);
  3      s_title  varchar2(50);
  4      s_dept   varchar2(20);
  5      s_cred   number;
  6      s_inst   varchar2(20);
  7      s_bld    varchar2(15);
  8      s_room   varchar2(10);
  9      s_tid    varchar2(10);
 10      s_count  number;
 11      cursor c is
 12          select c.course_id, c.title, c.dept_name, c.credits, i.name, s.building, s.room_number, s.time_slot_id,
 13          (select count(*) from takes t
 14           where t.course_id = s.course_id and t.sec_id = s.sec_id
 15           and t.semester = s.semester and t.year = s.year)
 16          from course c, section s, teaches te, instructor i
 17          where c.course_id = s.course_id
 18          and s.course_id = te.course_id and s.sec_id = te.sec_id
 19          and s.semester = te.semester and s.year = te.year
 20          and te.id = i.id;
 21  BEGIN
 22      open c;
 23      loop
 24          fetch c into s_cid, s_title, s_dept, s_cred, s_inst, s_bld, s_room, s_tid, s_count;
 25          exit when c%NOTFOUND;
 26          dbms_output.put_line('Course ID: ' || s_cid);
 27          dbms_output.put_line('Title: ' || s_title);
 28          dbms_output.put_line('Dept: ' || s_dept);
 29          dbms_output.put_line('Credits: ' || s_cred);
 30          dbms_output.put_line('Instructor: ' || s_inst);
 31          dbms_output.put_line('Location: ' || s_bld || ' Room: ' || s_room);
 32          dbms_output.put_line('Time Slot: ' || s_tid);
 33          dbms_output.put_line('Total Students: ' || s_count);
 34          dbms_output.put_line('-----------------------------------');
 35      end loop;
 36      close c;
 37* END;
 38  /
Course ID: BIO-101
Title: Intro. to Biology
Dept: Biology
Credits: 4
Instructor: Crick
Location: Painter Room: 514
Time Slot: B
Total Students: 1
-----------------------------------
Course ID: BIO-301
Title: Genetics
Dept: Biology
Credits: 4
Instructor: Crick
Location: Painter Room: 514
Time Slot: A
Total Students: 1
-----------------------------------
Course ID: CS-101
Title: Intro. to Computer Science
Dept: Comp. Sci.
Credits: 4
Instructor: Srinivasan
Location: Packard Room: 101
Time Slot: H
Total Students: 6
-----------------------------------
Course ID: CS-101
Title: Intro. to Computer Science
Dept: Comp. Sci.
Credits: 4
Instructor: Katz
Location: Packard Room: 101
Time Slot: F
Total Students: 1
-----------------------------------
Course ID: CS-190
Title: Game Design
Dept: Comp. Sci.
Credits: 4
Instructor: Brandt
Location: Taylor Room: 3128
Time Slot: E
Total Students: 0
-----------------------------------
Course ID: CS-190
Title: Game Design
Dept: Comp. Sci.
Credits: 4
Instructor: Brandt
Location: Taylor Room: 3128
Time Slot: A
Total Students: 2
-----------------------------------
Course ID: CS-315
Title: Robotics
Dept: Comp. Sci.
Credits: 3
Instructor: Srinivasan
Location: Watson Room: 120
Time Slot: D
Total Students: 2
-----------------------------------
Course ID: CS-319
Title: Image Processing
Dept: Comp. Sci.
Credits: 3
Instructor: Katz
Location: Watson Room: 100
Time Slot: B
Total Students: 1
-----------------------------------
Course ID: CS-319
Title: Image Processing
Dept: Comp. Sci.
Credits: 3
Instructor: Brandt
Location: Taylor Room: 3128
Time Slot: C
Total Students: 1
-----------------------------------
Course ID: CS-347
Title: Database System Concepts
Dept: Comp. Sci.
Credits: 3
Instructor: Srinivasan
Location: Taylor Room: 3128
Time Slot: A
Total Students: 2
-----------------------------------
Course ID: EE-181
Title: Intro. to Digital Systems
Dept: Elec. Eng.
Credits: 3
Instructor: Kim
Location: Taylor Room: 3128
Time Slot: C
Total Students: 1
-----------------------------------
Course ID: FIN-201
Title: Investment Banking
Dept: Finance
Credits: 3
Instructor: Wu
Location: Packard Room: 101
Time Slot: B
Total Students: 1
-----------------------------------
Course ID: HIS-351
Title: World History
Dept: History
Credits: 3
Instructor: El Said
Location: Painter Room: 514
Time Slot: C
Total Students: 1
-----------------------------------
Course ID: MU-199
Title: Music Video Production
Dept: Music
Credits: 3
Instructor: Mozart
Location: Packard Room: 101
Time Slot: D
Total Students: 1
-----------------------------------
Course ID: PHY-101
Title: Physical Principles
Dept: Physics
Credits: 4
Instructor: Einstein
Location: Watson Room: 100
Time Slot: A
Total Students: 1
-----------------------------------

PL/SQL procedure successfully completed.


-- 4. Find all students who take the course with Course-id: CS101 and if he/ she has less than 30 total credit (tot-cred), deregister the student from that course. (Delete the entry in Takes table)

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      s_id    varchar2(5);
  3      s_cred  number;
  4      cursor c is
  5          select s.id, s.tot_cred
  6          from student s, takes t
  7          where s.id = t.id
  8          and t.course_id = 'CS-101';
  9  BEGIN
 10      open c;
 11      loop
 12          fetch c into s_id, s_cred;
 13          exit when c%NOTFOUND;
 14          if s_cred < 30 then
 15              delete from takes
 16              where id = s_id
 17              and course_id = 'CS-101';
 18              dbms_output.put_line('Student ID: ' || s_id || ' deregistered (Credits: ' || s_cred || ')');
 19          else
 20              dbms_output.put_line('Student ID: ' || s_id || ' remains enrolled (Credits: ' || s_cred || ')');
 21          end if;
 22      end loop;
 23      if c%ROWCOUNT = 0 then
 24          dbms_output.put_line('No students found for course CS-101.');
 25      end if;
 26      close c;
 27      commit;
 28* END;
 29  /
Student ID: 00128 remains enrolled (Credits: 102)
Student ID: 12345 remains enrolled (Credits: 32)
Student ID: 45678 remains enrolled (Credits: 46)
Student ID: 45678 remains enrolled (Credits: 46)
Student ID: 54321 remains enrolled (Credits: 54)
Student ID: 76543 remains enrolled (Credits: 58)
Student ID: 98765 remains enrolled (Credits: 98)

PL/SQL procedure successfully completed.

-- 5. Alter StudentTable(refer Lab No. 8 Exercise) by resetting column LetterGrade to F. Then write a PL/SQL block to update the table by mapping GPA to the corresponding letter grade for each student

SQL> UPDATE StudentTable SET LetterGrade = 'F';

5 rows updated.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      s_sgpa  NUMBER;
  3      s_grade VARCHAR2(2);
  4      CURSOR c is
  5          SELECT gpa FROM StudentTable
  6          FOR UPDATE OF LetterGrade;
  7  BEGIN
  8      OPEN c;
  9      LOOP
 10          FETCH c INTO s_sgpa;
 11          EXIT WHEN c%NOTFOUND;
 12          IF s_sgpa >= 0 AND s_sgpa < 4 THEN s_grade := 'F';
 13          ELSIF s_sgpa >= 4 AND s_sgpa < 5 THEN s_grade := 'E';
 14          ELSIF s_sgpa >= 5 AND s_sgpa < 6 THEN s_grade := 'D';
 15          ELSIF s_sgpa >= 6 AND s_sgpa < 7 THEN s_grade := 'C';
 16          ELSIF s_sgpa >= 7 AND s_sgpa < 8 THEN s_grade := 'B';
 17          ELSIF s_sgpa >= 8 AND s_sgpa < 9 THEN s_grade := 'A';
 18          ELSIF s_sgpa >= 9 AND s_sgpa <= 10 THEN s_grade := 'A+';
 19          ELSE s_grade := NULL;
 20          END IF;
 21          UPDATE StudentTable
 22          SET LetterGrade = s_grade
 23          WHERE CURRENT OF c;
 24      END LOOP;
 25      CLOSE c;
 26      COMMIT;
 27* END;
 28  /

PL/SQL procedure successfully completed.

SQL> select lettergrade from studenttable;

LE
--
D
C
F
B
A+

-- 6. Write a PL/SQL block to print the list of Instructors teaching a specified course.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2      s_name varchar2(20);
  3      s_input varchar2(10) := '&course_id';
  4      cursor c(p_cid varchar2) is
  5          select i.name
  6          from instructor i, teaches t
  7          where i.id = t.id
  8          and t.course_id = p_cid;
  9  BEGIN
 10      open c(s_input);
 11      dbms_output.put_line('Instructors for ' || s_input || ':');
 12      loop
 13          fetch c into s_name;
 14          exit when c%NOTFOUND;
 15          dbms_output.put_line(s_name);
 16      end loop;
 17      if c%ROWCOUNT = 0 then
 18          dbms_output.put_line('No instructors found for this course.');
 19      end if;
 20      close c;
 21* END;
 22  /
Enter value for course_id: CS-101
old   3:     s_input varchar2(10) := '&course_id';
new   3:     s_input varchar2(10) := 'CS-101';
Instructors for CS-101:
Srinivasan
Katz

PL/SQL procedure successfully completed.

-- 7. Write a PL/SQL block to list the students who have registered for a course taught by his/her advisor

SQL> ED
Wrote file afiedt.buf

  1  DECLARE
  2      s_sid   varchar2(5);
  3      s_sname varchar2(20);
  4      s_cid   varchar2(8);
  5      s_aname varchar2(20);
  6      cursor c is
  7          select s.id, s.name, t.course_id, i.name
  8          from student s, takes t, advisor a, instructor i, teaches te
  9          where s.id = t.id
 10          and s.id = a.s_id
 11          and a.i_id = i.id
 12          and i.id = te.id
 13          and t.course_id = te.course_id
 14          and t.sec_id = te.sec_id
 15          and t.semester = te.semester
 16          and t.year = te.year;
 17  BEGIN
 18      open c;
 19      loop
 20          fetch c into s_sid, s_sname, s_cid, s_aname;
 21          exit when c%NOTFOUND;
 22          dbms_output.put_line('Student: ' || s_sname || ' (ID: ' || s_sid || ')');
 23          dbms_output.put_line('Course: ' || s_cid || ' taught by Advisor: ' || s_aname);
 24          dbms_output.put_line('---');
 25      end loop;
 26      if c%ROWCOUNT = 0 then
 27          dbms_output.put_line('No records found.');
 28      end if;
 29      close c;
 30* END;
 31  /
Student: Shankar (ID: 12345)
Course: CS-101 taught by Advisor: Srinivasan
---
Student: Shankar (ID: 12345)
Course: CS-315 taught by Advisor: Srinivasan
---
Student: Shankar (ID: 12345)
Course: CS-347 taught by Advisor: Srinivasan
---
Student: Peltier (ID: 44553)
Course: PHY-101 taught by Advisor: Einstein
---
Student: Tanaka (ID: 98988)
Course: BIO-101 taught by Advisor: Crick
---
Student: Tanaka (ID: 98988)
Course: BIO-301 taught by Advisor: Crick
---
Student: Aoi (ID: 76653)
Course: EE-181 taught by Advisor: Kim
---

PL/SQL procedure successfully completed.
