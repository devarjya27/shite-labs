students = LOAD '/user/240968040/lab5/students.csv' USING PigStorage(',')
AS (student_id:chararray, student_name:chararray, department:chararray, cgpa:float);
sorted_students = ORDER students BY cgpa DESC;
DUMP sorted_students;
STORE sorted_students INTO '/user/240968040/lab5/output_3/' USING PigStorage(',');
