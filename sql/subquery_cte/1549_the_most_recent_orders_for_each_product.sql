-- Write your PostgreSQL query statement below
with ranking_table as (
    select order_id, order_date, product_id,
    rank() over(partition by product_id order by order_date desc) as ranking
    from Orders
)

select b.product_name, a.product_id, a.order_id, a.order_date
from ranking_table a
left join Products b on a.product_id = b.product_id
where a.ranking = 1
order by b.product_name, a.product_id, a.order_id;