students = LOAD '/user/240968040/lab5/students.csv' USING PigStorage(',')
AS (student_id:chararray, name:chararray, department:chararray, cgpa:float);
grouped_data = GROUP students BY department;
dept_count = FOREACH grouped_data GENERATE group AS department, COUNT(students) AS student_count;
DUMP dept_count;
STORE dept_count INTO '/user/240968040/lab5/output_4/' USING PigStorage(',');
