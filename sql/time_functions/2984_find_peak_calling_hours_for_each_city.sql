-- Write your PostgreSQL query statement below
with extract_hour as (
    select
        city,
        extract(hour from call_time) as hour_time,
        count(*) as n_times
    from Calls
    group by city, extract(hour from call_time)
), rank_hour as (
    select *,
    rank() over(partition by city order by n_times desc) as ranking
    from extract_hour
)

select 
    city,
    hour_time as peak_calling_hour,
    n_times as number_of_calls
from rank_hour
where ranking = 1
order by hour_time desc, city desc;