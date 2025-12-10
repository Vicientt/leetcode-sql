-- Write your PostgreSQL query statement below
with count_direct_report as (
    select
        managerId,
        COUNT(*) as ndirect_report
    from
        Employee
    group by managerId
)

select
    b.name
from
    count_direct_report a
join
    Employee b
on a.managerId = b.id
where a.ndirect_report >= 5;
