-- Write your PostgreSQL query statement below
with find_max_salary as (
    select company_id,
    case when max(salary) < 1000 then 0
         when max(salary) > 10000 then 2
         else 1 end as max_salary
    from Salaries
    group by company_id
)
select a.company_id, a.employee_id, a.employee_name,
    case when b.max_salary = 0 then a.salary
         when b.max_salary = 2 then round(a.salary::numeric*0.51)
         else round(a.salary::numeric*0.76) end as salary
from Salaries a
left join find_max_salary b on a.company_id = b.company_id;
