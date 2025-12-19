-- Write your PostgreSQL query statement below

select
    a.candidate_id
from Candidates a
join Rounds b on a.interview_id = b.interview_id
where a.years_of_exp >= 2
group by a.candidate_id 
having sum(b.score) > 15
