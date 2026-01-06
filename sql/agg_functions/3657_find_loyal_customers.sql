-- Write your PostgreSQL query statement below
with find_eligible as (
    select
        customer_id
    from customer_transactions
    group by customer_id
    having count(case when transaction_type = 'purchase' then 1 end) >= 3 and max(transaction_date) - min(transaction_date) >= 30
)
select
    a.customer_id
from customer_transactions a
join find_eligible b on a.customer_id = b.customer_id
group by a.customer_id
having count(case when transaction_type = 'refund' then 1 end)::numeric/ count(*) < 0.2
order by a.customer_id;