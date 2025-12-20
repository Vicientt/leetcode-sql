-- Write your PostgreSQL query statement below
with find_type0 as (
    select distinct customer_id
    from Orders
    where order_type = 0
)
select order_id, customer_id, order_type
from Orders
where (customer_id in (select customer_id from find_type0) and order_type != 1) or customer_id not in (select customer_id from find_type0)
