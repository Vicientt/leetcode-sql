-- Write your PostgreSQL query statement below
with merge_exps as(
    select a.project_id, a.employee_id, b.experience_years,
    rank() over(partition by a.project_id order by b.experience_years desc) as ranking

    from Project a
    left join Employee b on a.employee_id = b.employee_id
)

select project_id, employee_id
from merge_exps
where ranking = 1;