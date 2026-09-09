courses = LOAD '/user/240968040/lab5/courses.csv' USING PigStorage(',')
AS (course_id:chararray, course_name:chararray, credits:int);

all_courses = GROUP courses ALL;

total_credits = FOREACH all_courses GENERATE SUM(courses.credits) AS total_credits_sum;

DUMP total_credits;
STORE total_credits INTO '/user/240968040/lab5/output_5/' USING PigStorage(',');
