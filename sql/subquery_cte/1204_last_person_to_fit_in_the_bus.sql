with prefix_sum as (
    select
        turn,
        person_name,
        sum(weight) over(order by turn) as summation
    from Queue
    order by turn desc
)
select person_name
from prefix_sum
where summation <= 1000
limit 1;