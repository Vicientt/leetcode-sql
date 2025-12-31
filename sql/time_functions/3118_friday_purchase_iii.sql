-- Write your PostgreSQL query statement below
with find_type_date_spend as (
    select
        b.membership,
        extract(week from a.purchase_date) - extract(week from date_trunc('month', a.purchase_date)) + 1 as week_of_month,
        a.amount_spend
    from Purchases a
    join Users b on a.user_id = b.user_id
    where to_char(a.purchase_date,'YYYY-MM') = '2023-11' and extract(dow from a.purchase_date) = 5
), real_spend as (
    select membership, week_of_month, sum(amount_spend) as total_amount
    from find_type_date_spend
    group by membership, week_of_month
), base_table as (
    select
        a.week_of_month,
        b.membership
    from generate_series(1,4) as a(week_of_month)
    cross join (values ('Premium'), ('VIP')) as b(membership)
)

select a.week_of_month, a.membership, coalesce(b.total_amount,0) as total_amount
from base_table a
left join real_spend b on a.week_of_month = b.week_of_month and a.membership = b.membership;