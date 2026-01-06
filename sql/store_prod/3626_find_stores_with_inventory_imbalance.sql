-- Write your PostgreSQL query statement below
with find_least3 as (
    select
        store_id
    from inventory
    group by store_id
    having count(distinct product_name) >= 3
), rank_product as (
    select
        a.store_id, a.product_name, a.quantity,
        rank() over(partition by a.store_id order by a.price desc) as most_exp,
        rank() over(partition by a.store_id order by a.price) as cheapest
    from inventory a
    join find_least3 b on a.store_id = b.store_id
)

select
    a.store_id, c.store_name, c.location,
    a.product_name as most_exp_product,
    b.product_name as cheapest_product,
    round(b.quantity::numeric/ a.quantity,2) as imbalance_ratio
from rank_product a
join rank_product b on a.store_id = b.store_id
join stores c on a.store_id = c.store_id
where a.most_exp = 1 and b.cheapest = 1 and b.quantity > a.quantity
order by imbalance_ratio desc, c.store_name;