-- Write your PostgreSQL query statement below
with check_order as (
    SELECT
        id,
        login_date,
        login_date - dense_rank() OVER (PARTITION BY id ORDER BY login_date)::int AS grp
    FROM Logins
)

select
    distinct a.id, a.name
from Accounts a
left join check_order b on a.id = b.id
group by a.id, a.name, b.grp  
having count(distinct login_date) >= 5
order by a.id;


