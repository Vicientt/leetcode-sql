-- Write your PostgreSQL query statement below
with find_position as (
    select
        num,
        frequency,
        sum(frequency) over(order by num) as position
    from Numbers
), find_median_position as (
    select
        round(sum(frequency)::numeric/2) as med_1,
        round((sum(frequency)+1)::numeric/2) as med_2
    from Numbers
), find_previous_position as (
    select
        *,
        coalesce(lag(position) over(order by num) + 1, 1) as prev_position
    from find_position
)
select avg(a.num) as median
from find_previous_position a
join find_median_position b on b.med_1 between a.prev_position and a.position or b.med_2 between a.prev_position and a.position;