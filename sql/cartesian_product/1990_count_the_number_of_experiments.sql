-- Write your PostgreSQL query statement below
with full_platform_experiment as (
    select a.platform, b.experiment_name
    from (values ('Android'), ('IOS'),('Web')) as a(platform)
    cross join
    (values ('Reading'), ('Sports'),('Programming')) as b(experiment_name)
)

select 
    a.platform, a.experiment_name, 
    count(case when b.experiment_id is not null then 1 else null end) as num_experiments
from full_platform_experiment a
left join Experiments b on a.platform = b.platform and a.experiment_name = b.experiment_name
group by a.platform, a.experiment_name;