-- Write your PostgreSQL query statement below
with three_generation as (
    select
        b.id as child_id,
        a.id,
        a.p_id
    from Tree a
    left join Tree b on a.id = b.p_id
), categorize_table as (
    select id,
        case when p_id is null then 'Root'
            when child_id is null then 'Leaf'
             else 'Inner' end as type
    from
        three_generation
)

select id, type
from categorize_table
group by id, type;
