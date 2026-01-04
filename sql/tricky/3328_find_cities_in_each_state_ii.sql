-- Write your PostgreSQL query statement below
with find_suitable_state as(
    select
        state,
        count(*) as matching_letter_count
    from cities
    where left(state,1) = left(city,1)
    group by state
), count_state as (
    select
        state,
        count(*) as n_city
    from cities
    group by state
    having count(*) >= 3
)

select 
    a.state,
    string_agg(a.city, ', ' order by a.city) as cities,
    b.matching_letter_count
from 
    cities a
join find_suitable_state b on a.state = b.state
where a.state in (select state from count_state)
group by a.state, b.matching_letter_count
order by matching_letter_count desc, state;

