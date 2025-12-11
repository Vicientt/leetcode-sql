-- Write your PostgreSQL query statement below
with request as (
    select
        requester_id as id,
        count(*) as num
    from RequestAccepted
    group by requester_id
), 
accept as (
    select
        accepter_id as id,
        count(*) as num
    from RequestAccepted
    group by accepter_id
),
merge_table as (
    select *
    from request

    union all

    select *
    from accept
)

select id, sum(num) as num
from merge_table
group by id
order by num desc
limit 1;
