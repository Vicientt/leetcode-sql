-- Write your PostgreSQL query statement below
with count_buy_2019 as (
    select
        buyer_id,
        count(*) num_item
    from Orders
    where extract(year from order_date) = 2019
    group by buyer_id
)

select a.user_id as buyer_id, a.join_date, coalesce(b.num_item, 0) as orders_in_2019
from Users a
left join count_buy_2019 b on a.user_id = b.buyer_id;