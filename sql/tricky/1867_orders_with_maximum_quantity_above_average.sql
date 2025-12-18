-- Write your PostgreSQL query statement below
with find_max_all as (
    select avg(quantity) as max_avg 
    from OrdersDetails
    group by order_id
)

select distinct order_id
from OrdersDetails
group by order_id
having max(quantity) > (select max(max_avg) from find_max_all)
