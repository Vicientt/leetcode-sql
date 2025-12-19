-- Write your PostgreSQL query statement below
with visit_purchase as (
    select a.member_id, count(*) as num_visit, count(case when b.charged_amount is not null then 1 else null end) as num_purchases
    from Visits a
    left join Purchases b on a.visit_id = b.visit_id
    group by a.member_id
)
select a.member_id, a.name, 
    case when b.num_visit is null or b.num_visit = 0 then 'Bronze'
         when b.num_purchases::numeric/ b.num_visit < 0.5 then 'Silver'
         when b.num_purchases::numeric/ b.num_visit >= 0.8 then 'Diamond'
         else 'Gold' end as category
from Members a
left join visit_purchase b on a.member_id = b.member_id;