-- Write your PostgreSQL query statement below
with find_item_seller as (
    select
        a.item_id,
        b.seller_id
    from Items a
    join Users b
    on a.item_brand = b.favorite_brand
), count_num_sold as (
    select
        a.seller_id,
        count(distinct case when a.item_id not in (select item_id from find_item_seller where a.seller_id = seller_id) then a.item_id end) as total_sell
    from Orders a
    group by a.seller_id
), rank_id as (
    select
        seller_id,
        total_sell,
        rank() over(order by total_sell desc) as ranking
    from count_num_sold
)

select seller_id, total_sell as num_items
from rank_id
where ranking = 1
order by seller_id;