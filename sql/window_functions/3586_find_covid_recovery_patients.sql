-- Write your PostgreSQL query statement below
with find_positive_test as (
    select
        a.patient_id, a.test_date as pos_date, b.test_date as neg_date
    from covid_tests a
    join covid_tests b on a.patient_id = b.patient_id and a.test_date < b.test_date
    where a.result = 'Positive' and b.result = 'Negative'
), first_pos_test as (
    select *,
    rank() over(partition by patient_id order by pos_date, neg_date) as ranking
    from find_positive_test
)
select
    a.patient_id, b.patient_name, b.age, a.neg_date - a.pos_date as recovery_time
from first_pos_test a
left join patients b on a.patient_id = b.patient_id
where a.ranking = 1
order by recovery_time, b.patient_name;