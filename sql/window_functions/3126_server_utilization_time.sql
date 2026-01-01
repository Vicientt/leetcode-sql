-- Write your PostgreSQL query statement below
with next_time as (
    select
        server_id,
        status_time,
        lead(status_time) over(partition by server_id order by status_time) as nexttime,
        session_status
    from Servers
), calculate_total_time as (
    select sum(extract(epoch from (nexttime - status_time))) as total_time
    from next_time
    where session_status = 'start'
)

select floor(total_time::numeric/(3600*24)) as total_uptime_days
from calculate_total_time;