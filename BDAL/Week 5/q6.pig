enrollments = LOAD '/user/240968040/lab5/enrollments.csv' USING PigStorage(',')
AS (student_id:chararray, course_id:chararray, semester:int);

semesters_only = FOREACH enrollments GENERATE semester;

unique_semesters = DISTINCT semesters_only;

DUMP unique_semesters;
STORE unique_semesters INTO '/user/240968040/lab5/output_6/' USING PigStorage(',');
