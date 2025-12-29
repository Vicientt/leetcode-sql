-- Write your PostgreSQL query statement below
with count_num_ticket as (
    select
        a.flight_id,
        count(case when b.passenger_id is not null then 1 else null end) as n_ticket,
        a.capacity
    from Flights a
    left join Passengers b on a.flight_id = b.flight_id
    group by a.flight_id, a.capacity
)

select
    flight_id,
    case when n_ticket > capacity then capacity else n_ticket end as booked_cnt,
    case when n_ticket > capacity then n_ticket - capacity else 0 end as waitlist_cnt
from count_num_ticket
order by flight_id;