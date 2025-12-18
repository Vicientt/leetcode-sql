with full_table as (
    select 'High Salary' as category
    union all
    select 'Average Salary' as category
    union all
    select 'Low Salary' as category
), classified as (
    select case when income < 20000 then 'Low Salary' when income > 50000 then 'High Salary' else 'Average Salary' end as category
    from Accounts
)
select
    a.category,
    count(case when b.category is not null then 1 else null end) as accounts_count
from full_table a
left join classified b on a.category = b.category
group by a.category;
