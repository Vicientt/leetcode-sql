-- Write your PostgreSQL query statement below
with generate_id as (
    select 
    sum(amount) as amount,
    visited_on,
    dense_rank() over(order by visited_on) as id
    from Customer
    group by visited_on
)
, final_table as(
select
    id,
    visited_on,
    sum(amount) over(order by visited_on range between interval '6 day' preceding and current row) as amount,
    round(avg(amount) over(order by visited_on range between interval '6 day' preceding and current row),2) as average_amount
from
    generate_id
)
select distinct visited_on, amount, average_amount
from final_table
where id >= 7
order by visited_on;