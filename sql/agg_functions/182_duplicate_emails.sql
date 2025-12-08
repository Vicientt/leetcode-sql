# Write your MySQL query statement below
with check_frequency as (
    select
        email,
        count(*) as frequency
    from
        Person
    group by email
)

select
    email
from
    check_frequency
where frequency >= 2