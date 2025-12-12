-- Write your PostgreSQL query statement below
with generate_id as (
    select 
        row_number() over(order by x, y) as id,
        x, y
    from Point2D
), smallest as (
    select a.id, min(sqrt((pow((a.x - b.x),2) + pow((a.y - b.y),2))::numeric)) as min_distance
    from generate_id a
    cross join generate_id b
    where a.id != b.id
    group by a.id
)
select round(min(min_distance),2) as shortest
from smallest;