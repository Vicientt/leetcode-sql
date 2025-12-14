-- Write your PostgreSQL query statement below
with find_former_later as (
    select 
        log_id,
        lag(log_id) over(order by log_id) as previous,
        lead(log_id) over(order by log_id) as latter
    from Logs
), choose_start as(
    select 
    row_number() over(order by log_id) as id,
    log_id as start_id
    from find_former_later 
    where previous is null or (log_id - previous) != 1
), choose_end as(
    select 
    row_number() over(order by log_id) as id,
    log_id as end_id
    from find_former_later 
    where latter is null or (latter - log_id) != 1
)
select
    a.start_id, b.end_id
from choose_start a 
join choose_end b on a.id = b.id;