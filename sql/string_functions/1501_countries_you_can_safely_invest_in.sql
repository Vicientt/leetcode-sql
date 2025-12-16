-- Write your PostgreSQL query statement below
with connect_table as (
select 
    a.caller_id, a.callee_id, a.duration, c.name as caller_country, e.name as callee_country
from
    Calls a
left join Person b on a.caller_id = b.id
left join Country c on left(b.phone_number, 3) = c.country_code

left join Person d on a.callee_id = d.id
left join Country e on left(d.phone_number,3) = e.country_code
), union_table as (
    select caller_country as country, duration from connect_table
    union all
    select callee_country as country, duration from connect_table
)

select country
from union_table
group by country
having avg(duration) > (select avg(duration) from union_table);