-- Write your PostgreSQL query statement below
select count(a.account_id) as accounts_count
from Subscriptions a
where (extract(year from a.start_date) = 2021 or extract(year from a.end_date) = 2021) and a.account_id in (
    select account_id from Streams where extract (year from stream_date) != 2021
)