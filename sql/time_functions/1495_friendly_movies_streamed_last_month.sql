-- Write your PostgreSQL query statement below
select
    distinct b.title 
from TVProgram a
join Content b on a.content_id = b.content_id
where b.Kids_content = 'Y' and to_char(a.program_date, 'YYYY-MM') = '2020-06' and b.content_type = 'Movies';