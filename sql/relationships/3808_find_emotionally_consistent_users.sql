-- Write your PostgreSQL query statement below
with filter_5 as (
    select
        user_id,
        count(*) as total_reaction
    from reactions
    group by user_id
    having count(*) >= 5
),
find_proportion as (
    select
        a.user_id,
        b.reaction as dominant_reaction,
        round(count(*)::numeric/ max(a.total_reaction), 2) as reaction_ratio
    from filter_5 a
    left join reactions b on a.user_id = b.user_id
    group by a.user_id, b.reaction
)
select *
from find_proportion
where reaction_ratio >= 0.6
order by reaction_ratio desc, user_id;