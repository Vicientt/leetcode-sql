-- Write your PostgreSQL query statement below
with group_filter_count as (
select
    distinct product_id,
    date_trunc('year', purchase_date) as year
from Orders
group by product_id, year
having count(*) >= 3
), check_year as (
    select product_id,
    year - dense_rank() over(partition by product_id order by year) * interval '1 year' as minus_year
    from group_filter_count
)
select distinct product_id
from check_year
group by product_id, minus_year
having count(*) >= 2;