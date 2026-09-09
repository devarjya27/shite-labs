students = LOAD '/user/240968040/lab5/students.csv' USING PigStorage(',')
AS (student_id:chararray, student_name:chararray, department:chararray, cgpa:float);
high_students = FILTER students BY cgpa > 8.5;
DUMP high_students;
STORE high_students INTO '/user/240968040/lab5/output_2/' USING PigStorage(',');
