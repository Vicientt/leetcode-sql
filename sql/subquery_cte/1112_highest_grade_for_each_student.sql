-- Write your PostgreSQL query statement below
with rank_class as (
    select student_id, course_id, grade,
    rank() over(partition by student_id order by grade desc) as ranking
    from Enrollments
),
choose_highest_grade as (
    select student_id, course_id, grade
    from rank_class
    where ranking = 1
),
rank_course as (
    select student_id, course_id, grade,
    rank() over(partition by student_id order by course_id) as ranking
    from choose_highest_grade
)

select student_id, course_id, grade
from rank_course
where ranking = 1
order by student_id;