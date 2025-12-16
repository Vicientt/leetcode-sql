-- Write your PostgreSQL query statement below
with paidby_table as (
    select
        paid_by as user_id,
        -sum(amount) as credit 
    from Transactions
    group by paid_by
), paidto_table as (
    select
        paid_to as user_id,
        sum(amount) as credit 
    from Transactions
    group by paid_to
), final_table as (
    select a.user_id, a.user_name, a.credit + coalesce(b.credit,0) + coalesce(c.credit,0) as credit 
    from Users a
    left join paidby_table b on a.user_id = b.user_id
    left join paidto_table c on a.user_id = c.user_id
)
select *, case when credit >= 0 then 'No' else 'Yes' end as credit_limit_breached
from final_table;