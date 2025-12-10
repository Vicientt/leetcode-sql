-- Write your PostgreSQL query statement below
with count_vote as(
    select 
        candidateId,
        count(*) as num_votes
    from
        Vote
    group by 
        candidateId
), rank_vote as(
    select *,
    rank() over(order by num_votes desc) as ranking
    from
        count_vote
)

select
    b.name
from
    rank_vote a
join Candidate b on a.candidateId = b.id
where a.ranking = 1;