with find_latest_month as (
    select
        *,
        rank() over(partition by id order by month desc) as ranking
    from Employee
)
select
    id, month,
    sum(salary) over(partition by id order by month range between 2 preceding and current row) as Salary
from find_latest_month
where ranking != 1
order by id, month desc;