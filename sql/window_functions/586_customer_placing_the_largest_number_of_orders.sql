-- Write your PostgreSQL query statement below
with count_order as (
    select
        customer_number,
        count(*) as norders
    from Orders
    group by customer_number
), rank_order as (
    select *,
        rank() over(order by norders desc) as ranking
    from
        count_order
)

select
    customer_number
from
    rank_order
where 
    ranking = 1;
