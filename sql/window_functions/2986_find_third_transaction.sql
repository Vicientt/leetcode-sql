-- Write your PostgreSQL query statement below
with set_rank_date as (
    select *,
    rank() over(partition by user_id order by transaction_date) as rank_date
    from Transactions
), set_rank_spend as (
    select *,
    rank() over(partition by user_id order by spend) as rank_spend
    from set_rank_date
    where rank_date <= 3
)

select 
    user_id,
    spend as third_transaction_spend,
    transaction_date as third_transaction_date
from set_rank_spend
where rank_date = 3 and rank_spend = 3
order by user_id;