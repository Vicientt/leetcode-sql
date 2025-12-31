-- Write your PostgreSQL query statement below
with merge_table as (
    select
        a.topping_name as top1, a.cost as cost1, b.topping_name as top2, b.cost as cost2, c.topping_name as top3, c.cost as cost3
    from Toppings a
    left join Toppings b on a.topping_name < b.topping_name
    left join Toppings c on b.topping_name < c.topping_name
    where a.topping_name is not null and b.topping_name is not null and c.topping_name is not null
)
select top1 || ',' || top2 || ',' || top3 as pizza,
cost1 + cost2 + cost3 as total_cost
from merge_table
order by total_cost desc, pizza;