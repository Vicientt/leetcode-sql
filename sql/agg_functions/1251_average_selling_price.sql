-- Write your PostgreSQL query statement below
with merge_price as (
    select
        a.product_id,
        b.purchase_date,
        b.units,
        a.price
    from Prices a
    left join UnitsSold b on a.product_id = b.product_id and b.purchase_date between a.start_date and a.end_date
)

select
    product_id,
    coalesce(round(sum(units*price)::numeric/sum(units),2),0) as average_price
from merge_price
group by product_id;