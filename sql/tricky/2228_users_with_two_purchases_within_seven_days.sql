-- Write your PostgreSQL query statement below
with next_purchase as (
    select user_id, purchase_date,
    lead(purchase_date) over (partition by user_id order by purchase_date) as next_purchase
    from Purchases
)
select distinct user_id
from next_purchase
where next_purchase is not null and next_purchase - purchase_date <= 7
order by user_id;