-- Write your PostgreSQL query statement below
with exclude_duplicate_1 as (
    select requester_id, accepter_id
    from RequestAccepted
    group by requester_id, accepter_id
),
exclude_duplicate_2 as (
    select sender_id, send_to_id
    from FriendRequest
    group by sender_id, send_to_id
)

select 
    case 
        when (select count(*) from exclude_duplicate_2) = 0 then 0.00
        else (round(count(*)::numeric/(select count(*) from exclude_duplicate_2), 2)) end as accept_rate
from exclude_duplicate_1;