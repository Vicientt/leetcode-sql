-- Write your PostgreSQL query statement below
with filter_tiv_2015 as (
    select
        tiv_2015
    from
        Insurance
    group by tiv_2015
    having count(*) > 1
), filter_location as (
    select
        lat,
        lon
    from Insurance
    group by lat, lon
    having count(*) = 1
),
merge_table as (
    select
        a.tiv_2016,
        b.tiv_2015,
        c.lat,
        c.lon
    from
        Insurance a
    left join filter_tiv_2015 b on a.tiv_2015 = b.tiv_2015
    left join filter_location c on a.lat = c.lat and a.lon = c.lon
)

select round(sum(tiv_2016)::numeric,2) as tiv_2016
from merge_table
where tiv_2015 is not null and lat is not null;