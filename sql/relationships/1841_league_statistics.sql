-- Write your PostgreSQL query statement below
with hometeam_table as (
    select 
        home_team_id as team_id,
        count(*) as matches_played,
        sum(case when home_team_goals > away_team_goals then 3 when home_team_goals = away_team_goals then 1 else 0 end) as points,
        sum(home_team_goals) as goal_for,
        sum(away_team_goals) as goal_against
    from Matches
    group by home_team_id
), awayteam_table as (
    select 
        away_team_id as team_id,
        count(*) as matches_played,
        sum(case when home_team_goals < away_team_goals then 3 when home_team_goals = away_team_goals then 1 else 0 end) as points,
        sum(away_team_goals) as goal_for,
        sum(home_team_goals) as goal_against
    from Matches
    group by away_team_id
), merge_table as (
    select *
    from hometeam_table

    union all

    select *
    from awayteam_table
)

select a.team_name, 
       sum(b.matches_played) as matches_played, 
       sum(b.points) as points,
       sum(b.goal_for) as goal_for,
       sum(b.goal_against) as goal_against,
       sum(b.goal_for) - sum(b.goal_against) as goal_diff
from Teams a
join merge_table b on a.team_id = b.team_id
group by a.team_name
order by points desc, goal_diff desc, team_name;