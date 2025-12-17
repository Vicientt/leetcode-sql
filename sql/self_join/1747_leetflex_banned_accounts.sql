-- Write your PostgreSQL query statement below
select
    distinct a.account_id
from LogInfo a
join LogInfo b on a.account_id = b.account_id and a.ip_address < b.ip_address
where (a.login <= b.logout and a.login >= b.login) or (a.logout >= b.login and b.login >= a.login);