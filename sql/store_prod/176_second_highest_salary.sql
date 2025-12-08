-- Write your PostgreSQL query statement below
with salary_ranking as (
    select
        salary,
        dense_rank() over(order by salary desc) as ranking
    from
        Employee
)

select( 
    select distinct salary
    from
        salary_ranking
    where 
        ranking = 2
) as SecondHighestSalary;