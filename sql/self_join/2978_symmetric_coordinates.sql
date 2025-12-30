-- Write your PostgreSQL query statement below
with generate_id as (
    select *,
    row_number() over(order by ctid) as id
    from Coordinates
)
select 
    distinct a.X, a.Y
from generate_id a
join generate_id b on a.X = b.Y and a.Y = b.X and a.id != b.id
and a.X <= a.Y
order by a.X, a.Y;