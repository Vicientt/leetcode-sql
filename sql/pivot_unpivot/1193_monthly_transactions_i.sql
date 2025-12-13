-- Write your PostgreSQL query statement below
select
    extract(year from trans_date)::text || '-' || case when extract(month from trans_date) < 10 then ('0' || (extract(month from trans_date)::text)) else extract(month from trans_date)::text end as month,
    country,
    count(*) as trans_count,
    sum(case when state = 'approved' then 1 else 0 end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from Transactions
group by month, country;