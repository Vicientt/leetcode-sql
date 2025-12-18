-- Write your PostgreSQL query statement below
with filter_group2 as (
    select
        salary 
    from Employees
    group by salary
    having count(*) >= 2
)

select
    a.employee_id, a.name, a.salary,
    dense_rank() over(order by a.salary) as team_id
from Employees a
join filter_group2 b on a.salary = b.salary
order by team_id, a.employee_id