with find_max_date as (
    select
        product_id,
        max(change_date) as max_date
    from Products
    where change_date <= date '2019-08-16'
    group by product_id
),
merge_find_latest_price as (
    select a.product_id, a.new_price
    from Products a
    join find_max_date b on a.product_id = b.product_id and a.change_date = b.max_date
    where b.max_date is not null
), 
find_all_product as (
    select distinct product_id 
    from Products
)

select a.product_id, coalesce(b.new_price, 10) as price
from find_all_product a
left join merge_find_latest_price b on a.product_id = b.product_id;