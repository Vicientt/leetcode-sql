-- Write your PostgreSQL query statement below
select
    order_date,
    round(count(case when order_date = customer_pref_delivery_date then 1 else null end)*100::numeric/ count(*),2) as immediate_percentage
from Delivery
group by order_date
order by order_date;