-- Write your PostgreSQL query statement below
with count_table as (
    select
        customer_id,
        product_id,
        count(*) as times_buy
    from Orders
    group by customer_id, product_id
), rank_table as (
    select *,
    rank() over(partition by customer_id order by times_buy desc) as ranking
    from count_table
)
select a.customer_id, a.product_id, b.product_name
from rank_table a
left join Products b on a.product_id = b.product_id
where ranking = 1;