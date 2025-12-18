-- Write your PostgreSQL query statement below
with merge_table as (
    select a.user_id, b.time_stamp, b.action
    from Signups a
    left join Confirmations b on a.user_id = b.user_id
)

select user_id,
       case when count(case when time_stamp is not null then 1 else null end) = 0 then 0.00 else
       round(count(case when action = 'confirmed' then 1 else null end)::numeric/count(*), 2) end as confirmation_rate
from merge_table
group by user_id;