-- Write your PostgreSQL query statement below
with categorize as (
    select 
        b.N as N2,
        a.N,
        a.P
    from Tree a
    left join Tree b on a.N = b.P
), final_table as (
    select n,
    case when p is null then 'Root'
        when n2 is null then 'Leaf'
        else 'Inner' end as Type
    from categorize
)
select
    n, min(Type) as Type
from final_table
group by n
order by n;