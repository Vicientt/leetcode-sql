-- Write your PostgreSQL query statement below
select  
    sum(a.apple_count + coalesce(b.apple_count, 0)) as apple_count,
    sum(a.orange_count + coalesce(b.orange_count,0)) as orange_count
from Boxes a
left join Chests b on a.chest_id = b.chest_id;