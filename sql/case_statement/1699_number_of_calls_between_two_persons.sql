-- Write your PostgreSQL query statement below
with reverse_column as (
    select
        case when from_id > to_id then to_id else from_id end as from_id,
        case when from_id > to_id then from_id else to_id end as to_id,
        duration
    from Calls
)

select 
    from_id as person1,
    to_id as person2,
    count(*) as call_count,
    sum(duration) as total_duration
from reverse_column
group by from_id, to_id;