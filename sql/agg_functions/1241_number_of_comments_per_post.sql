-- Write your PostgreSQL query statement below
select
    a.sub_id as post_id,
    count(distinct b.sub_id) as number_of_comments
from (select distinct sub_id from Submissions where parent_id is null) as a
left join Submissions b on a.sub_id = b.parent_id
group by a.sub_id
order by a.sub_id;