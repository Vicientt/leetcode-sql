-- Write your PostgreSQL query statement below
with find_num_employ as (
    select
        dep_id,
        count(*) as num_employee
    from Employees
    group by dep_id
), rank_dep as (
    select *,
    rank() over(order by num_employee desc) as ranking
    from find_num_employ
)

select b.emp_name as manager_name, a.dep_id
from rank_dep a
left join Employees b on a.dep_id = b.dep_id
where a.ranking = 1 and b.position = 'Manager'
order by dep_id;