-- Write your PostgreSQL query statement below
with merge_table as (
    select contest_id, gold_medal as medal
    from Contests

    union all

    select contest_id, silver_medal as medal
    from Contests

    union all

    select contest_id, bronze_medal as medal
    from Contests
), check_consecutive as (
    select distinct a.medal as user_id
    from merge_table a
    join merge_table b on a.medal = b.medal and a.contest_id + 1 = b.contest_id
    join merge_table c on b.medal = c.medal and b.contest_id + 1 = c.contest_id
), find_gold_medal as (
    select gold_medal as user_id
    from Contests
    group by gold_medal
    having count(*) >= 3
), total_table as (
    select *
    from check_consecutive

    union all
    select *
    from find_gold_medal
)

select distinct b.mail, b.name
from total_table a
join Users b on a.user_id = b.user_id;