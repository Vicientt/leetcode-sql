-- Write your PostgreSQL query statement below
with find_num_employee as(
    select
        company,
        round(count(*)::numeric/2) as med_1,
        round((count(*)+1)::numeric/2) as med_2
    from
        Employee
    group by company
        
), rank_salary as (
    select *,
    rank() over (partition by company order by salary, id) as ranking
    from Employee
)
select distinct
    a.id, a.company, a.salary
from rank_salary a
join find_num_employee b on a.company = b.company and (a.ranking = b.med_1 or a.ranking = b.med_2)