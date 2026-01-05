-- Write your PostgreSQL query statement below
with find_right_customer as (
    select
        user_id, 
        count(distinct case when activity_type = 'free_trial' or activity_type = 'paid' then activity_type end) as n_subscriptions
    from UserActivity
    group by user_id
    having count(distinct case when activity_type = 'free_trial' or activity_type = 'paid' then activity_type end) = 2
), merge_full as (
    select
        a.user_id, a.activity_date, activity_type, a.activity_duration
    from UserActivity a
    join find_right_customer b on a.user_id = b.user_id
)
select
    a.user_id, a.trial_avg_duration, b.paid_avg_duration
from 
    (select user_id, round(avg(activity_duration),2) as trial_avg_duration
    from merge_full where activity_type = 'free_trial' group by user_id) as a
join 
    (select user_id, round(avg(activity_duration),2) as paid_avg_duration
    from merge_full where activity_type = 'paid' group by user_id) as b on a.user_id = b.user_id
order by a.user_id;
