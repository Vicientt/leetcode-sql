-- Write your PostgreSQL query statement below
with filter_banned_user as (
    select *
    from Users
    where banned = 'No' and role = 'client'
), filter_banned_driver as (
    select *
    from Users
    where banned = 'No' and role = 'driver'
), filter_trips as (
    select
        a.client_id, a.driver_id, a.status, a.request_at
    from
        Trips a
    left join filter_banned_user b on a.client_id = b.users_id
    where b.banned is not null and (a.request_at >= '2013-10-01' and a.request_at <= '2013-10-03')
), final_table as (
select 
    request_at as Day,
    case when count(case when driver_id in (select users_id from filter_banned_driver) then 1 else null end) != 0 then
    round(sum(case when left(status, 3) = 'can' then 1 else 0 end)::numeric/ 
            count(case when driver_id in (select users_id from filter_banned_driver) then 1 else null end),2) end as "Cancellation Rate"
from filter_trips
group by request_at
)

select *
from final_table
where "Cancellation Rate" is not null;
