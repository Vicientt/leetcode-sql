-- Write your PostgreSQL query statement below
with rank_salary as (
    select
        name,
        salary,
        departmentId,
        rank() over(partition by departmentId order by salary desc) as ranking
    from
        Employee
)

select 
    b.name as Department, 
    a.name as Employee, 
    a.salary as Salary
from rank_salary a
left join Department b on a.departmentId = b.id
where a.ranking = 1;