-- Write your PostgreSQL query statement below
with match_table as (
    select a.passenger_id, a.arrival_time as pass_time,
    b.arrival_time as bus_time
    from Passengers a
    left join Buses b on a.arrival_time <= b.arrival_time
), choose_bus_for_passenger as (
    select passenger_id, pass_time, min(bus_time) as bus_time
    from match_table
    group by passenger_id, pass_time
), merge_buses_choose as (
    select
        a.bus_id, b.passenger_id
    from Buses a
    left join choose_bus_for_passenger b on a.arrival_time = b.bus_time
)

select bus_id,
    sum(case when passenger_id is not null then 1 else 0 end) as passengers_cnt
from merge_buses_choose
group by bus_id;