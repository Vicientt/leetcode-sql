-- Write your PostgreSQL query statement below
with swap_table as (
    select
        case when user1_id > user2_id then user2_id else user1_id end as user1_id,
        case when user2_id < user1_id then user1_id else user2_id end as user2_id
    from Friendship
), merge_table as (
    select a.user1_id, a.user2_id, b.user2_id as gen1, c.user1_id as gen2, b.user1_id as gen3, c.user2_id as gen4
    from swap_table a
    left join swap_table b on (a.user1_id = b.user1_id and a.user2_id != b.user2_id) or (a.user1_id = b.user2_id and a.user2_id != b.user1_id)
    left join swap_table c on (a.user2_id = c.user2_id and a.user1_id != c.user1_id) or (a.user2_id = c.user1_id and a.user1_id != c.user2_id)
)

select 
    user1_id,
    user2_id,
    count(*) as common_friend
from merge_table
where gen1 = gen2 or gen1 = gen4 or gen2 = gen3 or gen3 = gen4
group by user1_id, user2_id
having count(*) >= 3;

