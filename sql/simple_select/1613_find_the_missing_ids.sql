-- Write your PostgreSQL query statement below
with generate as (
select generate_series(1,max(customer_id)) as ids
from Customers
)

select *
from generate
where ids not in (select customer_id from Customers);