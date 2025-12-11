-- Write your PostgreSQL query statement below
with rank_high_earns as (
    select
        salary,
        departmentId,
        dense_rank() over(partition by departmentId order by salary desc) as ranking
    from
        Employee
), filter_high_earns as (
    select *
    from rank_high_earns
    where ranking <= 3
    group by salary, departmentId, ranking
)


select
    c.name as Department,
    a.name as Employee,
    a.salary as Salary 
from
    Employee a
left join filter_high_earns b on a.salary = b.salary and a.departmentId = b.departmentId
left join Department c on a.departmentId = c.id
where b.salary is not null and b.departmentId is not null;