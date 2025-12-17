-- Write your PostgreSQL query statement below
with count_table as (
    select Wimbledon as player_id, count(*) as gsl
    from Championships
    group by Wimbledon

    union all

    select Fr_open as player_id, count(*) as gsl
    from Championships
    group by Fr_open

    union all 

    select US_open as player_id, count(*) as gsl
    from Championships
    group by US_open

    union all

    select Au_open as player_id, count(*) as gsl
    from Championships
    group by Au_open
)

select a.player_id, a.player_name, sum(coalesce(b.gsl,0)) as grand_slams_count
from Players a
left join count_table b on a.player_id = b.player_id
group by a.player_id, a.player_name
having sum(coalesce(b.gsl,0)) != 0;
