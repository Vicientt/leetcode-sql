-- Write your PostgreSQL query statement below
select
    round(count(case when order_date = customer_pref_delivery_date then 1 end):: numeric * 100.0/ count(*), 2) as immediate_percentage
from Delivery;