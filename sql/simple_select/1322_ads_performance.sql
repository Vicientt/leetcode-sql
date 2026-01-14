-- Write your PostgreSQL query statement below
select
    ad_id,
    round(count(case when action = 'Clicked' then 1 end)::numeric * 100.0/ coalesce(nullif(count(case when action = 'Clicked' or action = 'Viewed' then 1 end),0),1), 2) as ctr
from Ads
group by ad_id
order by ctr desc, ad_id;