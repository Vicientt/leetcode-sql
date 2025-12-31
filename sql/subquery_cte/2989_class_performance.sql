-- Write your PostgreSQL query statement below
with rank_score as (
    select
        student_id,
        assignment1 + assignment2 + assignment3 as total_score,
        rank() over(order by (assignment1 + assignment2 + assignment3) desc) as rank_highest,
        rank() over(order by (assignment1 + assignment2 + assignment3)) as rank_lowest
    from Scores
), select_score as (
    select distinct (case when rank_highest = 1 then total_score when rank_lowest = 1 then -total_score end) as total_score
    from rank_score
    where rank_highest = 1 or rank_lowest = 1
)
select sum(total_score) as difference_in_score
from select_score;