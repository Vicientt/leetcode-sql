-- Write your PostgreSQL query statement below
with merge_result as (
    select
        a.id as p1,
        b.id as p2,
        abs(a.x_value - b.x_value)*abs(a.y_value - b.y_value) as area
    from Points a
    join Points b on a.id < b.id
)

select p1, p2, area
from merge_result
where area > 0
order by area desc, p1, p2;