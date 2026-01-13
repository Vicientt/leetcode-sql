-- Write your PostgreSQL query statement below
with cross_table as (
    select *
    from Students
    cross join Subjects
)

select
    a.student_id, a.student_name, a.subject_name,
    coalesce(count(case when b.subject_name is not null then 1 end), 0) as attended_exams
from cross_table a
left join Examinations b on a.student_id = b.student_id and a.subject_name = b.subject_name
group by a.student_id, a.student_name, a.subject_name
order by a.student_id, a.subject_name;