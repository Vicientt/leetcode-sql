-- Write your PostgreSQL query statement below
with categorize_time as (
    select a.product_id, 
        case when extract(month from a.sale_date) = 12 or extract(month from a.sale_date) <= 2 then 'Winter'
            when extract(month from a.sale_date) <= 5 then 'Spring'
            when extract(month from a.sale_date) <= 8 then 'Summer' else 'Fall' end as season,
        a.quantity,
        a.quantity * a.price as revenue,
        b.category
    from sales a
    left join products b on a.product_id = b.product_id
), calculate_total_and_ranking as (
    select
        category,
        season,
        sum(quantity) as total_quantity,
        sum(revenue) as total_revenue,
        rank() over(partition by season order by sum(quantity) desc, sum(revenue) desc) as ranking
    from categorize_time
    group by category, season
) 
select season, category, total_quantity, total_revenue 
from calculate_total_and_ranking
where ranking = 1;