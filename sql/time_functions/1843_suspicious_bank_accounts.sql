-- Write your PostgreSQL query statement below
with clean_table as (
    select
        a.account_id,
        date_trunc('month',a.day) as month,
        sum(a.amount) as total
    from Transactions a
    where a.type = 'Creditor'
    group by a.account_id, month
    having sum(a.amount) > (select max_income from Accounts where a.account_id = account_id)
), check_consecutive as (
    select *,
    month - (rank() over(partition by account_id order by month) * interval '1 month') as time
    from clean_table
)

select distinct account_id
from check_consecutive
group by time, account_id
having count(*) >= 2;

