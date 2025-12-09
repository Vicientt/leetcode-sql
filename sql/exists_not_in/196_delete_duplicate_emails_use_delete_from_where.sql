-- Write your PostgreSQL query statement below
with summary as (
    select
        id,
        email,
        row_number() over(partition by email order by id) as ranking
    from Person
)

delete from Person
where id in (select id from summary where ranking !=1);