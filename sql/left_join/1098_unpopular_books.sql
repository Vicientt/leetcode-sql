-- Write your PostgreSQL query statement below
with filter_sold as (
    select book_id, sum(quantity) as total_sold
    from Orders
    where dispatch_date between date '2019-06-23' - interval '12 month' and date '2019-06-23'
    group by book_id
)

select
    a.book_id,
    a.name
from
    Books a
left join filter_sold b on a.book_id = b.book_id
where (a.available_from not between (date '2019-06-23'- interval '1 month') and (date '2019-06-23')) and (b.total_sold < 10 or b.total_sold is null);