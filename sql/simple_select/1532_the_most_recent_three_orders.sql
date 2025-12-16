-- Write your PostgreSQL query statement below
with rank_table as (
    select *,
    rank() over(partition by customer_id order by order_date desc) as ranking
    from Orders
)

select a.name as customer_name, b.customer_id, b.order_id, b.order_date
from Customers a
join rank_table b on a.customer_id = b.customer_id
where b.ranking <= 3
order by customer_name, customer_id, order_date desc;