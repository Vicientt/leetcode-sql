-- Write your PostgreSQL query statement below
with create_lead as (
    select user_id,
    created_at,
    lead(created_at) over(partition by user_id order by created_at) as next_create
    from Users
)

select distinct user_id
from create_lead
where next_create - created_at <= 7