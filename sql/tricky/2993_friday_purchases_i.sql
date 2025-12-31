-- Write your PostgreSQL query statement below
with set_configuration as (
    select *,
    extract(week from purchase_date) - extract(week from date_trunc('month' ,purchase_date)) + 1 as week_of_month
    from Purchases
    where to_char(purchase_date, 'YYYY-MM') = '2023-11' and extract(dow from purchase_date) = 5
)

select week_of_month,
       purchase_date,
       sum(amount_spend) as total_amount
from set_configuration
group by week_of_month, purchase_date
order by week_of_month;
