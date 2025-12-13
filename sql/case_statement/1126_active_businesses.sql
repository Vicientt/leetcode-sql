-- Write your PostgreSQL query statement below
with cal_total_average as (
    select 
        event_type,
        avg(occurrences)::numeric as avg_occur
    from 
        Events
    group by event_type
),
decide_yesno as (
    select
        a.business_id,
        a.event_type,
        case when a.occurrences::numeric > b.avg_occur then 1 else 0 end as yes_no
    from Events a
    left join cal_total_average b on a.event_type = b.event_type
)

select business_id
from decide_yesno
group by business_id
having sum(yes_no) > 1;