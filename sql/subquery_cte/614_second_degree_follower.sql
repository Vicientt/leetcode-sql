-- Write your PostgreSQL query statement below
with count_follower as (
    select 
        followee,
        count(*) as num_follower
    from Follow
    group by followee
), count_follows as (
    select
        follower,
        count(*) as num_follows
    from Follow
    group by follower
)
select
    a.followee as follower, a.num_follower as num
from count_follower a
left join count_follows b on a.followee = b.follower
where a.num_follower is not null and b.num_follows is not null
order by a.followee;