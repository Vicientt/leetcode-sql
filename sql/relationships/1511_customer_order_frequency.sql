-- Write your PostgreSQL query statement below
with cal_cus_date as (
    select
        a.customer_id,
        to_char(a.order_date, 'YYYY-MM') as day,
        sum(a.quantity * b.price) as total_price
    from Orders a
    join Product b on a.product_id = b.product_id
    where to_char(a.order_date, 'YYYY-MM') = '2020-06' or to_char(a.order_date, 'YYYY-MM') = '2020-07'
    group by a.customer_id, to_char(a.order_date, 'YYYY-MM')
    having sum(a.quantity * b.price) >= 100
)

select
    a.customer_id, b.name
from cal_cus_date a
join Customers b on a.customer_id = b.customer_id
group by a.customer_id, b.name
having count(*) = 2;