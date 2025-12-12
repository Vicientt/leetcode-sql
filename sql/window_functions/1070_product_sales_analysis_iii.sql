with rank_year as (
    select
        product_id, year, quantity, price,
        rank() over(partition by product_id order by year) as ranking
    from
        Sales
)
select
    product_id,
    year as first_year,
    quantity,
    price
from rank_year
where ranking = 1
order by product_id;