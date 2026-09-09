
students = LOAD '/user/240968040/lab5/students.csv' USING PigStorage(',') 
    AS (student_id:chararray, student_name:chararray, department:chararray, cgpa:float);

enrollments = LOAD '/user/240968040/lab5/enrollments.csv' USING PigStorage(',') 
    AS (student_id:chararray, course_id:chararray, semester:int);

stud_enroll = JOIN students BY student_id, enrollments BY student_id;

result = FOREACH stud_enroll GENERATE 
    students::student_name, 
    students::department, 
    enrollments::course_id, 
    enrollments::semester;

DUMP result;
STORE result INTO '/user/240968040/lab5/output_7/' USING PigStorage(',');
