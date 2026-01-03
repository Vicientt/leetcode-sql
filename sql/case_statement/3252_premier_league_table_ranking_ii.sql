-- Write your PostgreSQL query statement below
with calculate_points as(
    select
        team_name,
        sum(wins*3 + draws) as points
    from
        TeamStats
    group by team_name
), percentage_rank as (
    select
        team_name,
        points,
        rank() over(order by points desc) as position,
        count(*) over() as total_teams
    from calculate_points
)

select
    team_name,
    points,
    position,
    case
        when position <= CEIL(0.33 * total_teams) THEN 'Tier 1'
        when position <= CEIL(0.66 * total_teams) THEN 'Tier 2'
        else 'Tier 3'
    END as tier
from percentage_rank
order by points desc, team_name;