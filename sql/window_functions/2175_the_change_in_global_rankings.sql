-- Write your PostgreSQL query statement below
with calculate_rank as (
    select a.team_id, a.name, a.points as original_point,
    a.points + b.points_change as new_point,
    rank() over(order by a.points desc, a.name) as original_rank
    from TeamPoints a
    left join PointsChange b on a.team_id = b.team_id
), new_rank_table as (
    select team_id, name, original_rank,
    dense_rank() over(order by new_point desc, name) as new_rank
    from calculate_rank
)
select team_id, name, original_rank - new_rank as rank_diff
from new_rank_table;