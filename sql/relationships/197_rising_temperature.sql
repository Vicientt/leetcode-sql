-- Write your PostgreSQL query statement below
select b.id
from Weather a
left join Weather b on a.recordDate+1 = b.recordDate
where b.temperature > a.temperature;