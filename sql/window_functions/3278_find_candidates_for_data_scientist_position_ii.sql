-- Write your PostgreSQL query statement below
with merge_can_proj as (
    select
        a.project_id, a.skill, a.importance, b.candidate_id, b.proficiency
    from Projects a
    left join Candidates b on a.skill = b.skill
), count_project_can as (
    select
        project_id, candidate_id, count(distinct skill) as total_skill
    from merge_can_proj
    group by project_id, candidate_id
), count_necessary_prj as (
    select
        project_id, count(*) as total_necess_skill 
    from Projects
    group by project_id
), merge_necess as (
    select
        a.project_id, a.candidate_id
    from count_project_can a
    join count_necessary_prj b on a.project_id = b.project_id
    where a.total_skill = b.total_necess_skill
), merge_table_full as (
    select
        a.project_id, a.candidate_id, b.skill, b.proficiency, c.importance
    from merge_necess a
    left join Candidates b on a.candidate_id = b.candidate_id
    left join Projects c on a.project_id = c.project_id
    where b.skill = c.skill
), cal_point as (
    select
        project_id,
        candidate_id,
        100 + sum(case when proficiency > importance then 10 when proficiency < importance then -5 else 0 end) as total_score,
        rank() over(partition by project_id order by sum(case when proficiency > importance then 10 when proficiency < importance then -5 else 0 end) desc, candidate_id) as ranking
    from merge_table_full
    group by project_id, candidate_id
)

select project_id, candidate_id, total_score as score
from cal_point
where ranking = 1
order by project_id;