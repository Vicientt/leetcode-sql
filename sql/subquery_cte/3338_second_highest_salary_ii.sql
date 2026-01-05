-- Write your PostgreSQL query statement below
with rank_employees as (
    select
        emp_id,
        dept,
        dense_rank() over(partition by dept order by salary desc) as ranking
    from employees
)

select
    emp_id, dept
from rank_employees
where ranking = 2
order by emp_id;