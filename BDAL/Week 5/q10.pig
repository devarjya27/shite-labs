courses = LOAD '/user/240968040/lab5/courses.csv' USING PigStorage(',')
AS (course_id:chararray, course_name:chararray, credits:int);

enrollments = LOAD '/user/240968040/lab5/enrollments.csv' USING PigStorage(',')
AS (student_id:chararray, course_id:chararray, semester:int);

course_enroll = JOIN courses BY course_id, enrollments BY course_id;
group_courses = GROUP course_enroll BY courses::course_id;
course_count = FOREACH group_courses GENERATE group AS course_id, COUNT(course_enroll) AS enroll_count;
sort_courses = ORDER course_count BY enroll_count DESC;
top3_courses = LIMIT sort_courses 3;
DUMP top3_courses;

STORE top3_courses INTO '/user/240968040/lab5/output_10/' USING PigStorage(',');
