with rank_table as (
    select
       player_id,
       event_date,
       rank() over(partition by player_id order by event_date) as ranking
    from
        Activity
),
connect_table as (
    select
        a.player_id,
        a.event_date as first_date,
        b.event_date as second_date
    from
        rank_table a
    join
        Activity b on a.event_date + 1 = b.event_date and a.player_id = b.player_id
    where
        a.ranking = 1
)

select
    round((count (distinct player_id))::numeric/(select count (distinct a.player_id) from Activity a) ,2) as fraction
from connect_table;