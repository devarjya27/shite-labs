students = LOAD '/user/240968040/lab5/students.csv' USING PigStorage(',')
AS (student_id:chararray, student_name:chararray, department:chararray, cgpa:float);
DUMP students;
cse_students = FILTER students BY department == 'Computer Science';
DUMP cse_students;
STORE cse_students INTO '/user/240968040/lab5/output_1/' USING PigStorage(',');

