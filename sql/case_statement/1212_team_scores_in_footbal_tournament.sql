-- Write your PostgreSQL query statement below
with cal_host as (
    select
        host_team,
        sum(case when host_goals > guest_goals then 3 when host_goals = guest_goals then 1 else 0 end) as total_score
    from Matches
    group by host_team
),
cal_guest as (
    select
        guest_team,
        sum(case when host_goals < guest_goals then 3 when host_goals = guest_goals then 1 else 0 end) as total_score
    from Matches
    group by guest_team
)

select
    a.team_id,
    a.team_name,
    coalesce(b.total_score,0) + coalesce(c.total_score,0) as num_points
from Teams a
left join cal_host b on a.team_id = b.host_team
left join cal_guest c on a.team_id = c.guest_team
order by num_points desc, team_id;