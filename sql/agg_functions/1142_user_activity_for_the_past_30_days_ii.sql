-- Write your PostgreSQL query statement below
with find_session_per_user as (
    select
        user_id,
        count(distinct session_id) as n_sessions
    from Activity
    where activity_date between date '2019-07-27' - interval '29 day' and '2019-07-27'
    group by user_id
)
select coalesce(round(avg(n_sessions), 2),0) as average_sessions_per_user
from find_session_per_user;