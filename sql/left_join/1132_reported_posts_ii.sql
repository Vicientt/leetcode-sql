-- Write your PostgreSQL query statement below
with remove_duplicate_row as (
    select distinct *
    from Actions
),
filter_report_by_day as (
    select
    a.post_id, 
    a.action_date,
    b.remove_date
    from remove_duplicate_row a
    left join Removals b on a.post_id = b.post_id
    where a.extra = 'spam' and a.action = 'report'
), 
cal_percent_by_day as (
    select
        action_date,
        count(distinct case when remove_date is not null then post_id end)::numeric/ count(distinct post_id) * 100.0 as percentage
    from filter_report_by_day
    group by action_date
)
select round(avg(percentage),2) as average_daily_percent
from cal_percent_by_day;


