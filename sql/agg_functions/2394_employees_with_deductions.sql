-- Write your PostgreSQL query statement below
with calculate_timescreen as (
    select 
        employee_id,
        sum(ceil(extract (epoch from (out_time - in_time)/ 60.0)))/60.0 as total_time
    from Logs
    group by employee_id
)
select a.employee_id
from Employees a
left join calculate_timescreen b on a.employee_id = b. employee_id
where total_time is null or total_time < needed_hours;