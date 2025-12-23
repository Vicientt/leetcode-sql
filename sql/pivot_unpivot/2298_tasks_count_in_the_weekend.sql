-- Write your PostgreSQL query statement below
with categorize_dayofweek as (
    select
        task_id,
        case when extract(dow from submit_date) between 1 and 5 then 'working' else 'weekend' end as type
    from Tasks
)
select
    count(case when type = 'weekend' then 1 else null end) as weekend_cnt,
    count(case when type = 'working' then 1 else null end) as working_Cnt
from 
    categorize_dayofweek;