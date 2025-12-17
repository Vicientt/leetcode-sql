-- Write your PostgreSQL query statement below
with difference_date as (
    select 
        user_id,
        coalesce(lead(visit_date) over(partition by user_id order by visit_date),'2021-1-1') - visit_date as biggest_window
    from UserVisits
    order by user_id
)
select user_id, max(biggest_window) as biggest_window
from difference_date
group by user_id
order by user_id;