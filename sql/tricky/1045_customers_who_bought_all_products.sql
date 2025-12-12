-- Write your PostgreSQL query statement below
with merge_table as (
    select
        distinct a.product_key as product_key,
        b.customer_id
    from
        Product a
    left join Customer b on a.product_key = b.product_key
    where b.customer_id is not null
),
count_product_per_id as (
    select
        customer_id,
        count(*) as num_product
    from merge_table
    group by customer_id
)

select customer_id
from count_product_per_id
where num_product = (select count(*) from Product);

