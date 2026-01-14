-- Write your PostgreSQL query statement below
select
    b.product_name,
    sum(a.unit) as unit
from Orders a
join Products b on a.product_id = b.product_id
where to_char(a.order_date, 'YYYY-MM') = '2020-02'
group by b.product_name
having sum(a.unit) >= 100;