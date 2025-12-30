-- Write your PostgreSQL query statement below
with count_vote_per_person as (
    select
        voter,
        count(case when candidate is not null then 1 else null end) as n_vote
    from votes
    group by voter
), calculate_point as (
select b.candidate, sum(round((1.00/a.n_vote::numeric),5)) as n_point
from count_vote_per_person a
join Votes b on a.voter = b.voter
where b.candidate is not null
group by b.candidate
), rank_point as (
    select candidate,
    rank() over(order by n_point desc) as ranking
    from calculate_point
)

select candidate
from rank_point
where ranking = 1
order by candidate;