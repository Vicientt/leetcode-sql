-- Write your PostgreSQL query statement below
with rank_table as (
    select
        transaction_id,
        rank() over(partition by day order by amount desc) as ranking
    from Transactions
)
select transaction_id
from rank_table
where ranking = 1
order by transaction_id;
