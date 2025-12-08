WITH Table_1 AS(
SELECT
  a.emp_id,
  a.manager_id,
  b.manager_id as senior_manager,
  c.manager_id as upper_senior_manager
FROM
  employees a
LEFT JOIN
  employees b ON a.manager_id = b.emp_id
LEFT JOIN
  employees c ON b.manager_id = c.emp_id
),
Table_2 AS(
SELECT
  a.senior_manager,
  a.manager_id
FROM 
  Table_1 a
WHERE NOT EXISTS
  (SELECT 1
  FROM Table_1 b
  WHERE a.senior_manager = b.upper_senior_manager)
AND 
  a.senior_manager IS NOT NULL
)

SELECT
 b.manager_name,
 COUNT(DISTINCT a.manager_id)
FROM
  Table_2 a
JOIN
  employees b ON a.senior_manager = b.manager_id
GROUP BY
  b.manager_name;