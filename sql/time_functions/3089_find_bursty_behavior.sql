-- Write your PostgreSQL query statement below
with find_weekly_post as (
    select
        user_id,
        count(*)::numeric/4 as avg_weekly_posts
    from Posts
    where to_char(post_date,'YYYY-MM') = '2024-02' and post_date != '2024-02-29'
    group by user_id
), find_7day_post as(
    select
        user_id,
        post_date,
        count(*) over(partition by user_id order by post_date range between interval '6 day' preceding and current row) as total_7day_post
    from Posts
    where to_char(post_date,'YYYY-MM') = '2024-02' and post_date != '2024-02-29'
), find_max_7day_post as (
    select user_id,
    max(total_7day_post) as max_7day_posts
    from find_7day_post
    group by user_id
)

select a.user_id, a.max_7day_posts, b.avg_weekly_posts
from find_max_7day_post a
join find_weekly_post b on a.user_id = b.user_id
where a.max_7day_posts::numeric >= 2*avg_weekly_posts
order by a.user_id;