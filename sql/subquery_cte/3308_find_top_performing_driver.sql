-- Write your PostgreSQL query statement below
with merge_table as (
    select
        c.driver_id, b.vehicle_id, b.fuel_type, a.distance, c.accidents, a.rating
    from
        Trips a
    left join Vehicles b on a.vehicle_id = b.vehicle_id
    left join Drivers c on b.driver_id = c.driver_id
), cal_score as (
    select
        fuel_type,
        driver_id,
        sum(distance) as distance,
        min(accidents) as num_accidents,
        round(avg(rating),2) as rating
    from merge_table
    group by fuel_type, driver_id
), rank_score as (
    select *,
    rank() over (partition by fuel_type order by rating desc, distance desc, num_accidents) as ranking
    from cal_score
)
select fuel_type, driver_id, rating, distance
from rank_score
where ranking = 1
order by fuel_type;