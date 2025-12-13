with find_first_order as (
    select *,
    rank() over(partition by customer_id order by order_date) as ranking
    from Delivery
)

select 
    round(sum(case when order_date = customer_pref_delivery_date then 1 else 0 end)::numeric/ count(*) * 100.0,2) as immediate_percentage
from find_first_order
where ranking = 1;