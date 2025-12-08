CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (
    -- Write your PostgreSQL query statement below.
    with salary_ranking as (
        select
            e.salary,
            dense_rank() over(order by e.salary desc) as ranking
        from
            Employee e
    )

    select
        (select distinct
            a.salary
        from
            salary_ranking a
        where ranking = N)
  );
END;
$$ LANGUAGE plpgsql;