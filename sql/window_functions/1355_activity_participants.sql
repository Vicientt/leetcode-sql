-- Write your PostgreSQL query statement below
with count_activity as (
    select activity, count(*) as total_number
    from Friends
    group by activity
)
, match_table as (
    select
        a.name as activity,
        coalesce(b.total_number,0) as total_number
    from
        Activities a
    left join count_activity b on a.name = b.activity
), rank_table as (
    select activity,
    rank() over(order by total_number desc) as rank_desc,
    rank() over(order by total_number) as rank_no_desc
    from match_table
)
select activity
from rank_table
where rank_desc != 1 and rank_no_desc != 1;

