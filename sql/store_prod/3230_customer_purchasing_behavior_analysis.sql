-- Write your PostgreSQL query statement below
with without_top_cat as (
    select
        a.customer_id,
        sum(a.amount) as total_amount,
        count(*) as transaction_count,
        count(distinct b.category) as unique_categories,
        round(avg(a.amount),2) as avg_transaction_amount,
        round(count(*)*10 + sum(a.amount)::numeric/ 100.0,2) as loyalty_score
    from Transactions a
    left join Products b on a.product_id = b.product_id
    group by a.customer_id
), watch_category as (
    select
        a.customer_id,
        b.category,
        max(a.transaction_date) as most_recent_date,
        count(*) as n_items
    from Transactions a
    left join Products b on a.product_id = b.product_id
    group by a.customer_id, b.category
), rank_category as (
    select
        customer_id,
        category,
        rank() over(partition by customer_id order by n_items desc, most_recent_date desc) as ranking
    from watch_category
)

select a.customer_id, a.total_amount, a.transaction_count, a.unique_categories, a.avg_transaction_amount, b.category as top_category, a.loyalty_score
from without_top_cat a
join rank_category b on a.customer_id = b.customer_id
where b.ranking = 1
order by a.loyalty_score desc, a.customer_id;