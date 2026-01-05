-- Write your PostgreSQL query statement below
with rank_employee_3 as (
    select
        employee_id, review_date, rating,
        rank() over(partition by employee_id order by review_date desc) as ranking
    from performance_reviews
), find_employee_3 as (
    select
        a.employee_id, c.rating - a.rating as improvement_score
    from rank_employee_3 a
    join rank_employee_3 b on a.employee_id = b.employee_id 
    join rank_employee_3 c on a.employee_id = c.employee_id
    where a.ranking = 3 and b.ranking = 2 and c.ranking = 1 and a.rating < b.rating and b.rating < c.rating
)

select
    a.employee_id, b.name, a.improvement_score
from find_employee_3 a
left join employees b on a.employee_id = b.employee_id
order by a.improvement_score desc, b.name;
