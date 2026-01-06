-- Write your PostgreSQL query statement below
with categorize as (
    select
        driver_id,
        case when extract(month from trip_date) between 1 and 6 then 'First' else 'Second' end as date_type,
        avg(distance_km::numeric/ fuel_consumed) as total_consumption
    from trips
    group by driver_id, (case when extract(month from trip_date) between 1 and 6 then 'First' else 'Second' end)
), compare_table as (
    select
        a.driver_id,
        a.total_consumption as first_half_avg,
        b.total_consumption as second_half_avg
    from categorize a
    join categorize b on a.driver_id = b.driver_id
    where a.date_type = 'First' and b.date_type = 'Second'
)

select
    a.driver_id, b.driver_name,
    round(a.first_half_avg, 2) as first_half_avg,
    round(a.second_half_avg, 2) as second_half_avg,
    round(a.second_half_avg - a.first_half_avg, 2) as efficiency_improvement
from compare_table a
left join drivers b on a.driver_id = b.driver_id
where a.first_half_avg < a.second_half_avg
order by efficiency_improvement desc, b.driver_name;