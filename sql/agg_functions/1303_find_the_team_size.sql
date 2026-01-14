-- Write your PostgreSQL query statement below
with find_team_size as (
    select
        team_id,
        count(*) as team_size
    from Employee
    group by team_id
)
select
    a.employee_id,
    b.team_size
from Employee a
left join find_team_size b on a.team_id = b.team_id;