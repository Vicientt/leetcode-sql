-- Write your PostgreSQL query statement below
with first_col_table as (
    select row_number() over(order by first_col) as id,
    first_col
    from Data
), second_col_table as (
    select row_number() over(order by second_col desc) as id,
    second_col
    from Data
)

select a.first_col, b.second_col
from first_col_table a
join second_col_table b on a.id = b.id
order by a.id;