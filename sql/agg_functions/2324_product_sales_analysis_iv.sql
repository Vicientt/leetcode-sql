-- Write your PostgreSQL query statement below
with calculate_sale as (
    select a.user_id, a.product_id, sum((a.quantity * b.price)) as total
    from Sales a
    join Product b on a.product_id = b.product_id
    group by a.user_id, a.product_id
), 
ranking_sale as (
    select *,
    rank() over(partition by user_id order by total desc) as ranking
    from calculate_sale
)
select user_id, product_id
from ranking_sale
where ranking = 1;