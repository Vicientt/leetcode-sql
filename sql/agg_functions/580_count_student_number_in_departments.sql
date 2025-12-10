-- Write your PostgreSQL query statement below
with count_student as (
    select
        dept_id,
        count(*) num_students
    from Student
    group by dept_id
)

select
    a.dept_name,
    coalesce(b.num_students,0) as student_number
from
    Department a
left join
    count_student b on a.dept_id = b.dept_id
order by student_number desc, dept_name;