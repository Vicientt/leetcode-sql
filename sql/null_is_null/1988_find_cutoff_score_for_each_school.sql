-- Write your PostgreSQL query statement below
with min_score as (
    select min(score) as score, student_count
    from Exam
    group by student_count
), appropriate_score as (
    select
        a.school_id,
        a.capacity,
        (select max(student_count) from min_score where student_count <= a.capacity) as student_count
    from Schools a
)
select a.school_id, coalesce(b.score,-1) as score
from appropriate_score a
left join min_score b on a.student_count = b.student_count;