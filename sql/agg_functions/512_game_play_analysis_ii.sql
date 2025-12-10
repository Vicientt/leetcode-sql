-- Write your PostgreSQL query statement below
with find_first_date as (
    select
        player_id,
        min(event_date) as first_date
    from
        Activity
    group by
        player_id
)

select
    a.player_id,
    a.device_id
from
    Activity a
join find_first_date b on a.player_id = b.player_id and a.event_date = b.first_date;