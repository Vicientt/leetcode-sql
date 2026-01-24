-- Write your PostgreSQL query statement below
with find_consecutive as (
    select
        id, visit_date, people,
        count(id) over(order by id range between 2 preceding and current row) as last_pos,
        count(id) over(order by id range between 1 preceding and 1 following) as mid_pos,
        count(id) over(order by id range between current row and 2 following) as first_pos
    from Stadium
    where people >= 100
)
select id, visit_date, people
from find_consecutive
where last_pos = 3 or mid_pos = 3 or first_pos = 3
order by visit_date;