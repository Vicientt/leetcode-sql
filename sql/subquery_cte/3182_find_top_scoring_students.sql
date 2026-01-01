-- Write your PostgreSQL query statement below
with course_vs_enroll as (
    select
        c.student_id, c.name as student_name, a.name as course_name, a.course_id, a.major, b.grade
    from 
        courses a
    left join enrollments b on a.course_id = b.course_id
    join students c on b.student_id = c.student_id
    where b.grade = 'A'
), require_course_num as (
    select
        major,
        count(*) as num_courses
    from courses
    group by major
), stu_course_take_with_A as (
    select
        student_id,
        major,
        count(*) as num_courses_take
    from course_vs_enroll
    group by student_id, major
)
select a.student_id
from stu_course_take_with_A a
join require_course_num b on a.major = b.major
where a.num_courses_take = b.num_courses and a.major in (select major from students where a.student_id = student_id)
order by a.student_id;