-- Write your PostgreSQL query statement below
with choose_rank as (
    select user_id, gender,
    rank() over(partition by gender order by user_id) as within_group_rank,
    case gender 
        when 'female' then 1 
        when 'other' then 2
        when 'male' then 3
    end as type_rank
    from Genders
)
select user_id, gender
from choose_rank
order by within_group_rank, type_rank;