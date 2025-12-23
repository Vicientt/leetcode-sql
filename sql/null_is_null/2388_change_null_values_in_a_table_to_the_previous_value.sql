-- Write your PostgreSQL query statement below
with generate_id as (
    select
        rank() over(order by ctid) as generate_id,
        *
    from CoffeeShop
), find_match_id as (
    select 
        a.id,
        a.drink,
        case when drink is not null then generate_id else (select max(generate_id) from generate_id where generate_id < a.generate_id and drink is not null) end as id_match
    from generate_id a
)

select a.id, b.drink
from find_match_id a
left join generate_id b on a.id_match = b.generate_id;