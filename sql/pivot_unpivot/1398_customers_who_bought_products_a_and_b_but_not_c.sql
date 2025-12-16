-- Write your PostgreSQL query statement below
with count_ABC as (
    select customer_id,
    count(distinct case when (product_name = 'A' or product_name = 'B' or product_name = 'C') then product_name end) as check_item_AB,
    count(distinct case when (product_name = 'C') then product_name end) as check_item_C
    from Orders
    group by customer_id
)
select a.customer_id, b.customer_name
from count_ABC a
left join Customers b on a.customer_id = b.customer_id
where a.check_item_AB = 2 and a.check_item_C = 0;