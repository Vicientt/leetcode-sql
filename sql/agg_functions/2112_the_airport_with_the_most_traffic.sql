-- Write your PostgreSQL query statement below
with count_flight as (
    select airport_id, sum(flights_count) as flights_count
    from (
        select departure_airport as airport_id, flights_count
        from Flights

        union all

        select arrival_airport as airport_id, flights_count
        from Flights
    ) merge_table
    group by airport_id
), rank_table as (
    select airport_id,
    rank() over(order by flights_count desc) as ranking
    from count_flight
)

select airport_id
from rank_table
where ranking = 1;