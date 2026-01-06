-- Write your PostgreSQL query statement below
with categorize_day as (
    select
        employee_id,
        extract(week from meeting_date) as week_date,
        sum(duration_hours) as total_hours
    from meetings
    group by employee_id, extract(week from meeting_date)
)

select
    a.employee_id, b.employee_name, b.department, count(distinct a.week_date) as meeting_heavy_weeks
from categorize_day a
join employees b on a.employee_id = b.employee_id
where a.total_hours > 20
group by a.employee_id, b.employee_name, b.department
having count(distinct a.week_date) >= 2
order by meeting_heavy_weeks desc, b.employee_name;