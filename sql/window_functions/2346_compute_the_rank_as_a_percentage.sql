-- Write your PostgreSQL query statement below
with rank_table as (
    select 
        a.student_id,
        a.department_id,
        rank() over(partition by a.department_id order by a.mark desc) as ranking,
        (select count(*) from Students b where a.department_id = b.department_id) as count_student
    from Students a
)

select
    a.student_id, a.department_id,
    case when (select count(*) - 1 from Students b where a.department_id = b.department_id) = 0 then 0.00 else
    round((a.ranking - 1)::numeric * 100/ (select count(*) - 1 from Students b where a.department_id = b.department_id), 2) end as percentage
from rank_table a;

-- select * 
-- from rank_table;
