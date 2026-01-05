-- Write your PostgreSQL query statement below
with merge_pair as (
    select
        a.product_id as product1_id, b.product_id as product2_id, count(distinct a.user_id) as customer_count
    from ProductPurchases a
    join ProductPurchases b on a.user_id = b.user_id and a.product_id < b.product_id
    group by a.product_id, b.product_id
    having count(distinct a.user_id) >= 3
)
select a.product1_id, a.product2_id, b.category as product1_category, c.category as product2_category, a.customer_count
from merge_pair a
left join ProductInfo b on a.product1_id = b.product_id
left join ProductInfo c on a.product2_id = c.product_id
order by a.customer_count desc, a.product1_id, a.product2_id;