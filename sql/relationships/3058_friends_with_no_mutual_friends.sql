-- Write your PostgreSQL query statement below
with merge_reverse as (
    select user_id1, user_id2
    from Friends
    union all
    select user_id2 as user_id1, user_id1 as user_id2
    from Friends
), find_friend as (
    select
        a.user_id1,
        a.user_id2,
        b.user_id2 as user_id3
    from merge_reverse a
    left join merge_reverse b on a.user_id2 = b.user_id1
), find_mutual_1 as (
    select a.user_id1, a.user_id2
    from find_friend a
    join find_friend b on (a.user_id1 = b.user_id2 and a.user_id2 = b.user_id1 and a.user_id3 = b.user_id3)
), find_mutual as (
    select a.user_id1, a.user_id2
    from Friends a
    join find_mutual_1 b on a.user_id1 = b.user_id1 and a.user_id2 = b.user_id2
)

select a.user_id1, a.user_id2
from Friends a
left join find_mutual b on a.user_id1 = b.user_id1 and a.user_id2 = b.user_id2
where b.user_id1 is null
order by user_id1, user_id2;