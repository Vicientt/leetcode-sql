-- Write your PostgreSQL query statement below
with generate_rank as (
    select *,
    rank() over(partition by state order by fraud_score desc) as ranking
    from Fraud
), calculate_top_5_percent as (
    select
        state,
        ceil(0.05*count(*)) as top_5
    from Fraud
    group by state
)
select policy_id, state, fraud_score
from generate_rank
where ranking <= (select distinct b.top_5 from calculate_top_5_percent b where state = b.state)
order by state, fraud_score desc, policy_id;