-- Write your PostgreSQL query statement below
with filter_student_subject as (
    select
        student_id, subject, count(distinct exam_date) as total_time
    from Scores
    group by student_id, subject
    having count(distinct exam_date) >= 2
), eligible_stu as (
    select
        a.student_id, a.subject, a.score, a.exam_date
    from Scores a
    join filter_student_subject b on a.student_id = b.student_id and a.subject = b.subject
), find_first_last_score as (
    select *,
    rank() over(partition by student_id, subject order by exam_date) as first_date,
    rank() over(partition by student_id, subject order by exam_date desc) as latest_date
    from eligible_stu
)
select
    a.student_id, a.subject, a.score as first_score, b.score as latest_score
from find_first_last_score a
join find_first_last_score b on a.student_id = b.student_id and a.subject = b.subject 
where a.first_date = 1 and b.latest_date = 1 and a.score < b.score
order by a.student_id, a.subject;