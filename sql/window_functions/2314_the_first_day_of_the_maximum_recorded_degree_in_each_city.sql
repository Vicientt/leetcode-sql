-- Write your PostgreSQL query statement below
with rank_degree as (
    select *,
    rank() over(partition by city_id order by degree desc, day) as ranking
    from Weather
)
select city_id, day, degree
from rank_degree
where ranking = 1;