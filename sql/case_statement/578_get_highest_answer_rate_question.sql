-- Write your PostgreSQL query statement below
-- answer/ show

with rate_action as (
    select
        question_id,
        sum(case when action = 'answer' then 1 else 0 end)::numeric/ sum(case when action = 'show' then 1 else 0 end) as rate
    from SurveyLog
    group by question_id
)

select
    question_id as survey_log
from rate_action
order by rate desc, question_id
limit 1;