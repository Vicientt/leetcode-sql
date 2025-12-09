-- Write your PostgreSQL query statement below
with rankover as (
select
    player_id,
    event_date,
    rank() over(partition by player_id order by event_date) as ranking
from
    Activity
)

select
    player_id,
    event_date as first_login
from rankover
where ranking = 1;