-- Write your PostgreSQL query statement below
with convert_transaction as (
    select
        to_char(a.trans_date, 'YYYY-MM') as month,
        a.country,
        count(case when a.state = 'approved' then 1 else null end) as approved_count,
        sum(case when a.state = 'approved' then amount else 0 end) as approved_amount
    from Transactions a
    group by a.country, month
), convert_chargebacks as (
    select
        to_char(a.trans_date, 'YYYY-MM') as month,
        b.country,
        count(*) as chargeback_count,
        sum(amount) as chargeback_amount
    from Chargebacks a
    join Transactions b on a.trans_id = b.id
    group by month, b.country
), final_table as (
select
    coalesce(a.month, b.month) as month,
    coalesce(a.country, b.country) as country,
    coalesce(a.approved_count,0) as approved_count,
    coalesce(a.approved_amount,0) as approved_amount,
    coalesce(b.chargeback_count,0) as chargeback_count,
    coalesce(b.chargeback_amount,0) as chargeback_amount
from convert_transaction a
full outer join convert_chargebacks b on a.month = b.month and a.country = b.country
)

select * 
from final_table
where 
    approved_count != 0 or
    chargeback_count != 0;