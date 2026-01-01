-- Write your PostgreSQL query statement below
with find_sequence as (
    select
        seat_id,
        seat_id - rank() over(order by seat_id) as sequence_st
    from
        Cinema
    where free = 1
), num_time_per_sequence as (
    select
        sequence_st,
        count(*) as n_times
    from find_sequence
    group by sequence_st
), longest_sequence as (
    select
        sequence_st,
        n_times,
        rank() over(order by n_times desc) as ranking
    from num_time_per_sequence
), find_consecutive as (
    select
        a.seat_id, b.n_times as consecutive_seats_len, a.sequence_st
    from find_sequence a
    join longest_sequence b on a.sequence_st = b.sequence_st
    where b.ranking = 1
)
select 
    min(seat_id) as first_seat_id,
    max(seat_id) as last_seat_id,
    consecutive_seats_len
from find_consecutive
group by sequence_st, consecutive_seats_len
order by first_seat_id;