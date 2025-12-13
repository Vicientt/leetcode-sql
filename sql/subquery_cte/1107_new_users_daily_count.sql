-- Write your PostgreSQL query statement below
with filter_login as (
    select 
        user_id, activity, min(activity_date) as activity_date_1
    from Traffic
    where (activity = 'login')
    group by user_id, activity
    having (min(activity_date) between date '2019-06-30' - interval '90 day' and date '2019-06-30')
)
select
    activity_date_1 as login_date,
    count(distinct user_id) as user_count
from filter_login
group by activity_date_1;