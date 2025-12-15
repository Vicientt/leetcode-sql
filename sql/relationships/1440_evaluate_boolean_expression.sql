-- Write your PostgreSQL query statement below
with merge_table as (
    select 
        a.left_operand, a.operator, a.right_operand, b.value as x_value, c.value as y_value
    from Expressions a
    left join Variables b on a.left_operand = b.name
    left join Variables c on a.right_operand = c.name
)
select
    left_operand, operator, right_operand,
    case when operator = '>' then (case when x_value > y_value then 'true' else 'false' end)
         when operator = '<' then (case when x_value < y_value then 'true' else 'false' end)
         else (case when x_value = y_value then 'true' else 'false' end) end as value
from merge_table;