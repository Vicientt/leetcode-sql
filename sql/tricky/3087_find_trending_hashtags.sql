-- Write your PostgreSQL query statement below
with extract_tweet as (
    select
    user_id, tweet_id,
    substring(tweet from '#\w+') as hashtag,
    to_char(tweet_date, 'YYYY-MM') as tweet_date
    from Tweets
)

select hashtag, count(*) as hashtag_count
from extract_tweet
where tweet_date = '2024-02'
group by hashtag
order by hashtag_count desc, hashtag desc
limit 3;
