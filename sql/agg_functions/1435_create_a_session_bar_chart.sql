-- Write your PostgreSQL query statement below
with categorize as (
    select
        case 
            when duration::numeric/ 60.0 < 5 then '[0-5>'
            when duration::numeric/ 60.0 < 10 then '[5-10>'
            when duration::numeric/ 60.0 < 15 then '[10-15>'
            else '15 or more' end as bin,
        1 as check_number
    from Sessions
)
select
    a.bin, count(case when b.check_number is not null then 1 end) as total
from (
    values
        ('[0-5>'),
        ('[5-10>'),
        ('[10-15>'),
        ('15 or more')
) as a(bin)
left join categorize b on a.bin = b.bin
group by a.bin;