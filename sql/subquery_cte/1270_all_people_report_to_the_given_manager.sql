-- Write your PostgreSQL query statement below
with merge_table as (
select
    a.employee_id,
    b.employee_id as manager1,
    c.employee_id as manager2,
    c.manager_id as head
from Employees a
left join Employees b on a.manager_id = b.employee_id
left join Employees c on b.manager_id = c.employee_id
)

select employee_id
from merge_table 
where head = 1 and employee_id != 1;