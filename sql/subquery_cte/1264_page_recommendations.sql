-- Write your PostgreSQL query statement below
with filter_1_like as (
    select *
    from Likes
    where user_id = 1
)
select distinct a.page_id as recommended_page
from Likes a
join Friendship b on (a.user_id = b.user1_id and b.user2_id = 1) or (a.user_id = b.user2_id and b.user1_id = 1)
where a.page_id not in (select page_id from filter_1_like)