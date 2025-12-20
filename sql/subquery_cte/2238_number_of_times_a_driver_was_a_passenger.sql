-- Write your PostgreSQL query statement below
with choose_table as (
    select driver_id, passenger_id
    from Rides
    where passenger_id in (select driver_id from Rides)
)
select
    a.driver_id, sum(case when b.driver_id is not null then 1 else 0 end) as cnt
from 
    (select distinct driver_id from Rides) a
left join choose_table b on a.driver_id = b.passenger_id
group by a.driver_id;