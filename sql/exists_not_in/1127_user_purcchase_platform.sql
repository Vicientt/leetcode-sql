-- Write your PostgreSQL query statement below
with find_day as (
    select
        distinct spend_date
    from Spending
),
find_buy_both as (
    select
        user_id,
        spend_date,
        'both' as platform,
        sum(amount) as total_amount,
        count(distinct user_id) as total_users
    from Spending
    group by spend_date, user_id
    having count(*) = 2
), final_both_table as (
    select
        a.spend_date,
        coalesce(b.platform, 'both') as platform,
        coalesce(b.total_amount, 0) as total_amount,
        coalesce(b.total_users, 0) as total_users
    from find_day a 
    left join find_buy_both b on a.spend_date = b.spend_date
), first_mobile_table as (
    select
        spend_date,
        'mobile' as platform,
        sum(amount) as total_amount,
        count(distinct user_id) as total_users
    from Spending a
    where user_id not in (select user_id from find_buy_both b where a.spend_date = b.spend_date) and platform = 'mobile'
    group by spend_date, platform
), final_mobile_table as (
    select
        a.spend_date,
        coalesce(b.platform, 'mobile') as platform,
        coalesce(b.total_amount, 0) as total_amount,
        coalesce(b.total_users, 0) as total_users
    from find_day a 
    left join first_mobile_table b on a.spend_date = b.spend_date
), first_desktop_table as (
    select
        spend_date,
        'desktop' as platform,
        sum(amount) as total_amount,
        count(distinct user_id) as total_users
    from Spending a
    where user_id not in (select user_id from find_buy_both b where a.spend_date = b.spend_date) and platform = 'desktop'
    group by spend_date, platform
), final_desktop_table as (
    select
        a.spend_date,
        coalesce(b.platform, 'desktop') as platform,
        coalesce(b.total_amount, 0) as total_amount,
        coalesce(b.total_users, 0) as total_users
    from find_day a 
    left join first_desktop_table b on a.spend_date = b.spend_date
)

select spend_date, platform, total_amount, total_users
from final_both_table

union all

select *
from final_mobile_table

union all

select *
from final_desktop_table;

-- select count(*)
-- from find_day;

