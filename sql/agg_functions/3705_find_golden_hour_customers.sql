-- Write your PostgreSQL query statement below
with find_3_orders as (
    select
        customer_id,
        count(*) as total_orders
    from restaurant_orders 
    group by customer_id
    having count(*) >= 3
), stat_table as (
    select
        a.customer_id,
        count(case when a.order_timestamp::time between '11:00:00' and '14:00:00' or a.order_timestamp::time between '18:00:00' and '21:00:00' then 1 end)::numeric * 100.0/count(*) as peak_hour_percentage,
        round(avg(case when a.order_rating is not null then a.order_rating end),2) as average_rating,
        count(case when a.order_rating is not null then a.order_rating end)::numeric/ count(*) as check_n_ratings
    from restaurant_orders a
    group by a.customer_id
)

select a.customer_id, b.total_orders, round(a.peak_hour_percentage) as peak_hour_percentage, a.average_rating
from stat_table a
join find_3_orders b on a.customer_id = b.customer_id
where a.peak_hour_percentage >= 60 and a.average_rating >= 4.0 and a.check_n_ratings >= 0.5
order by a.average_rating desc, a.customer_id desc;