-- Write your PostgreSQL query statement below
with average_temp as (
    select
        country_id,
        avg(weather_state) as average_weather
    from Weather
    where to_char(day, 'YYYY-MM') = '2019-11'
    group by country_id
)

select 
    a.country_name, 
    case when b.average_weather <= 15 then 'Cold' 
        when b.average_weather >= 25 then 'Hot' else 'Warm' end as weather_type
from Countries a
join average_temp b on a.country_id = b.country_id;