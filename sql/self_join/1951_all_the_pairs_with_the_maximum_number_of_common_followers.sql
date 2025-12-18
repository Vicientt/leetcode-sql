-- Write your PostgreSQL query statement below
with merge_table as (
    select
        a.user_id as user1_id, b.user_id as user2_id
    from Relations a
    join Relations b on a.follower_id = b.follower_id and a.user_id < b.user_id
), final_table as (
    select 
        user1_id,
        user2_id,
        count(*) as n_followers
    from merge_table
    group by user1_id, user2_id
)

select user1_id, user2_id
from final_table
where n_followers = (select max(n_followers) from final_table)