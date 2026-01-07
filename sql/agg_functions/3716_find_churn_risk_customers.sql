-- Write your PostgreSQL query statement below
with check_rank_cancel as (
    select
        event_id, user_id, event_date, event_type, plan_name, monthly_amount, rank() over(partition by user_id order by event_date desc, event_id desc) as latest_date
    from subscription_events 
), check_active_current_plan as (
    select
        a.event_id, a.user_id, a.event_date, a.event_type, a.plan_name, a.monthly_amount, (select max(monthly_amount) from subscription_events where user_id = a.user_id and event_id != a.event_id group by user_id) as max_historical_amount
    from check_rank_cancel a
    where a.latest_date = 1 and a.event_type != 'cancel' and a.monthly_amount < 0.5 * (select max(monthly_amount) from subscription_events where user_id = a.user_id and event_id != a.event_id group by user_id)::numeric
), find_max_day as (
    select
        user_id,
        max(event_date) - min(event_date) as days_as_subscriber
    from subscription_events
    group by user_id
    having max(event_date) - min(event_date) >= 60
), find_downgrade as(
    select
        distinct user_id
    from subscription_events
    where event_type = 'downgrade'
)

select a.user_id, a.plan_name as current_plan, a.monthly_amount as current_monthly_amount, a.max_historical_amount, b.days_as_subscriber
from check_active_current_plan a
join find_max_day b on a.user_id = b.user_id
join find_downgrade c on a.user_id = c.user_id
order by days_as_subscriber desc, a.user_id;