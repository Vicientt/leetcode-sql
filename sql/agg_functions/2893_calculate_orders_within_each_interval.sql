select 
    ceil(minute/6.00) as interval_no,
    sum(order_count) as total_orders
from Orders
group by ceil(minute/6.00)
order by interval_no;