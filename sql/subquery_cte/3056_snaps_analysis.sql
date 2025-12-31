-- Write your PostgreSQL query statement below
with cal_total_time as (
    select b.age_bucket, a.activity_type, sum(a.time_spent) as total_time
    from Activities a
    join Age b on a.user_id = b.user_id
    group by b.age_bucket, a.activity_type
), merge_table as (
    select 
        a.age_bucket,
        a.activity_type as open,
        a.total_time as open_time,
        b.activity_type as send,
        b.total_time as send_time
    from cal_total_time a
    full join cal_total_time b on a.age_bucket = b.age_bucket and a.activity_type != b.activity_type
    where (a.activity_type = 'open') or (a.activity_type = 'send' and b.activity_type is null)
), final_table as (
    select
        age_bucket,
        case when open = 'send' then null else 'open' end as open,
        case when open = 'send' then 0 else open_time end as open_time,
        case when open = 'send' then 'send' else 'send' end as send,
        case when open = 'send' then open_time else send_time end as send_time
    from merge_table
)
select 
    age_bucket,
    round(send_time::numeric/(send_time + open_time)*100.0, 2) as send_perc,
    round(open_time::numeric/(send_time + open_time)*100.0, 2) as open_perc
from final_table;