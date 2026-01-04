-- Write your PostgreSQL query statement below
with check_next_time as (
    select
        a.employee_id, a.start_time, a.end_time, b.start_time as next_start_time
    from EmployeeShifts a
    join EmployeeShifts b on a.start_time < b.start_time and a.end_time > b.start_time and a.employee_id = b.employee_id
)
select employee_id, count(*) as overlapping_shifts
from check_next_time
group by employee_id;