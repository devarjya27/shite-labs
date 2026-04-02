-- 1. Based on the University database Schema in Lab 2, write a row trigger that records along with the time any change made in the Takes (ID, course-id, sec-id, semester, year, grade) table in log_change_Takes (Time_Of_Change, ID, courseid,sec-id, semester, year, grade).

SQL> create table log_change_takes (
  2      time_of_change timestamp,
  3      id varchar2(5),
  4      course_id varchar2(8),
  5      sec_id varchar2(8),
  6      semester varchar2(6),
  7      year number(4,0),
  8      grade varchar2(2)
  9  );

Table created.

SQL> ed
Wrote file afiedt.buf

  1  create or replace trigger trg_log_takes
  2  after insert or update or delete on takes
  3  for each row
  4  begin
  5      if deleting then
  6          insert into log_change_takes (time_of_change, id, course_id, sec_id, semester, year, grade)
  7          values (current_timestamp, :old.id, :old.course_id, :old.sec_id, :old.semester, :old.year, :old.grade);
  8      else
  9          insert into log_change_takes (time_of_change, id, course_id, sec_id, semester, year, grade)
 10          values (current_timestamp, :new.id, :new.course_id, :new.sec_id, :new.semester, :new.year, :new.grade);
 11      end if;
 12* end;
SQL> /

Trigger created.

SQL> delete from takes where id=12345;

4 rows deleted.

SQL> select * from log_change_takes;

TIME_OF_CHANGE
---------------------------------------------------------------------------
ID    COURSE_I SEC_ID   SEMEST       YEAR GR
----- -------- -------- ------ ---------- --
24-MAR-26 02.35.02.611000 PM
12345 CS-101   1        Fall         2009 C

24-MAR-26 02.35.02.613000 PM
12345 CS-190   2        Spring       2009 A

24-MAR-26 02.35.02.613000 PM
12345 CS-315   1        Spring       2010 A


TIME_OF_CHANGE
---------------------------------------------------------------------------
ID    COURSE_I SEC_ID   SEMEST       YEAR GR
----- -------- -------- ------ ---------- --
24-MAR-26 02.35.02.613000 PM
12345 CS-347   1        Fall         2009 A

-- 2. Based on the University database schema in Lab: 2, write a row trigger to insert the existing values of the Instructor (ID, name, dept-name, salary) table into a new table Old_ Data_Instructor (ID, name, dept-name, salary) when the salary table is updated.

SQL> create table old_data_instructor (
  2      id varchar2(5),
  3      name varchar2(20),
  4      dept_name varchar2(20),
  5      salary number(8,2),
  6      date_changed date
  7  );

Table created.

SQL> ed
Wrote file afiedt.buf

  1  create or replace trigger trg_save_old_instructor
  2  before update of salary on instructor
  3  for each row
  4  begin
  5      insert into old_data_instructor (id, name, dept_name, salary, date_changed)
  6      values (:old.id, :old.name, :old.dept_name, :old.salary, sysdate);
  7* end;
SQL> /

Trigger created.

SQL> update instructor set salary = 50000 where id=76766;

1 row updated.

SQL> select * from old_data_instructor;

ID    NAME                 DEPT_NAME                SALARY DATE_CHAN
----- -------------------- -------------------- ---------- ---------
76766 Crick                Biology                   30000 24-MAR-26


-- 3. Based on the University Schema, write a database trigger on Instructor that checks the following:
-- • The name of the instructor is a valid name containing only alphabets.
-- • The salary of an instructor is not zero and is positive
-- • The salary does not exceed the budget of the department to which the instructor belongs

SQL> ed
Wrote file afiedt.buf

  1  create or replace trigger trg_validate_instructor
  2  before insert or update on instructor
  3  for each row
  4  declare
  5    v_dept_budget number;
  6  begin
  7    if not regexp_like(:new.name, '^[A-Za-z ]+$') then
  8      raise_application_error(-20001, 'invalid name: must contain only alphabets.');
  9    end if;
 10    if :new.salary <= 0 then
 11      raise_application_error(-20002, 'invalid salary: must be a positive non-zero value.');
 12    end if;
 13    select budget into v_dept_budget
 14    from department
 15    where dept_name = :new.dept_name;
 16    if :new.salary > v_dept_budget then
 17      raise_application_error(-20003, 'invalid salary: exceeds the department budget.');
 18    end if;
 19* end;
 20  /

Trigger created.

SQL> insert into instructor values (5656, 'Bohr', 'Physics', '-30000');
insert into instructor values (5656, 'Bohr', 'Physics', '-30000')
            *
ERROR at line 1:
ORA-20002: invalid salary: must be a positive non-zero value.
ORA-06512: at "DS18LAB15.TRG_VALIDATE_INSTRUCTOR", line 8
ORA-04088: error during execution of trigger
'DS18LAB15.TRG_VALIDATE_INSTRUCTOR'


SQL> insert into instructor values (5656, '67', 'Physics', '30000');
insert into instructor values (5656, '67', 'Physics', '30000')
            *
ERROR at line 1:
ORA-20001: invalid name: must contain only alphabets.
ORA-06512: at "DS18LAB15.TRG_VALIDATE_INSTRUCTOR", line 5
ORA-04088: error during execution of trigger
'DS18LAB15.TRG_VALIDATE_INSTRUCTOR'

-- 4. Create a transparent audit system for a table Client_master (client_no, name, address, Bal_due). The system must keep track of the records that are being deleted or updated. The functionality being when a record is deleted or modified the original record details and the date of operation are stored in the auditclient (client_no, name, bal_due, operation, userid, opdate) table, then the delete or update is allowed to go through.


SQL> create table client_master (
  2      client_no varchar2(6) primary key,
  3      name varchar2(20),
  4      address varchar2(30),
  5      bal_due number(10,2)
  6  );

Table created.

SQL>
SQL> create table auditclient (
  2      client_no varchar2(6),
  3      name varchar2(20),
  4      bal_due number(10,2),
  5      operation varchar2(10),
  6      userid varchar2(20),
  7      opdate date
  8  );

Table created.

SQL> insert into client_master values ('c001', 'ivan bayross', 'mumbai', 5000);

1 row created.

SQL> insert into client_master values ('c002', 'mamta muzumdar', 'madras', 2000);

1 row created.

SQL> insert into client_master values ('c003', 'chhaya bankar', 'mumbai', 0);

1 row created.

SQL> commit;

Commit complete.

SQL> ed
Wrote file afiedt.buf

  1  create or replace trigger trg_audit_client
  2  before update or delete on client_master
  3  for each row
  4  declare
  5      v_op varchar2(10);
  6  begin
  7      if updating then
  8          v_op := 'update';
  9      else
 10          v_op := 'delete';
 11      end if;
 12      insert into auditclient (client_no, name, bal_due, operation, userid, opdate)
 13      values (:old.client_no, :old.name, :old.bal_due, v_op, user, sysdate);
 14* end;
 15  /

Trigger created.

SQL> delete from client_master where client_no = 'c002';

1 row deleted.

SQL> select * from auditclient;

CLIENT NAME                    BAL_DUE OPERATION  USERID               OPDATE
------ -------------------- ---------- ---------- -------------------- ---------
c002   mamta muzumdar             2000 delete     DS18LAB15            24-MAR-26


-- 5. Based on the University database Schema in Lab 2, create a view Advisor_Student which is a natural join on Advisor, Student and Instructor tables. Create an INSTEAD OF trigger on Advisor_Student to enable the user to delete the corresponding entries in Advisor table.

SQL> create or replace view advisor_student as
  2  select
  3      s.id as student_id,
  4      s.name as student_name,
  5      i.id as instructor_id,
  6      i.name as instructor_name
  7  from student s
  8  join advisor a on s.id = a.s_id
  9  join instructor i on i.id = a.i_id;

View created.

SQL> ed
Wrote file afiedt.buf

  1  create or replace trigger trg_delete_advisor
  2  instead of delete on advisor_student
  3  for each row
  4  begin
  5      delete from advisor
  6      where s_id = :old.student_id
  7      and i_id = :old.instructor_id;
  8* end;
SQL> /

Trigger created.

SQL> delete from advisor_student
  2  where student_id = '00128';

1 row deleted.

SQL> select * from advisor where s_id = '00128';

no rows selected
