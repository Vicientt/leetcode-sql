-- Write your PostgreSQL query statement below
select distinct
    a.num as ConsecutiveNums
from
    Logs a
left join
    Logs b on a.id + 1 = b.id and a.num = b.num
left join
    Logs c on b.id + 1 = c.id and b.num = c.num
where
    b.num is not null and c.num is not null;