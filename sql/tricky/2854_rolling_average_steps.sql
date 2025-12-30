-- Write your PostgreSQL query statement below
with rank_origin_to_find_3 as (
    select
        user_id,
        steps_date,
        steps_date - (rank() over(partition by user_id order by steps_date) * interval '1 day') as original_date,
        steps_count
    from Steps
), find_3_conse as (
    select distinct
        user_id,
        original_date
    from rank_origin_to_find_3
    group by user_id, original_date
    having count(*) >= 3
),  merge_available_date as (
    select
        row_number() over(partition by a.user_id order by b.steps_date) as id,
        a.user_id,
        b.steps_date,
        b.steps_count
    from find_3_conse a
    left join rank_origin_to_find_3 b on a.user_id = b.user_id and b.original_date = a.original_date
), final_table as (
select
    id,
    user_id,
    steps_date,
    round(avg(steps_count::numeric) over(partition by user_id order by steps_date range between interval '2 day' preceding and current row),2) as rolling_average 
from merge_available_date
)

select user_id, steps_date, rolling_average
from final_table
where id >= 3;
