students = LOAD '/user/240968040/lab5/students.csv' USING PigStorage(',')
AS (student_id:chararray, student_name:chararray, department:chararray, cgpa:float);

grouped_students = GROUP students BY department;

dept_avg_cgpa = FOREACH grouped_students GENERATE 
    group AS department, 
    AVG(students.cgpa) AS avg_cgpa;

filtered_dept = FILTER dept_avg_cgpa BY avg_cgpa > 8.0;

sorted_dept = ORDER filtered_dept BY avg_cgpa DESC;

DUMP sorted_dept;
STORE sorted_dept INTO '/user/240968040/lab5/output_9/' USING PigStorage(',');
