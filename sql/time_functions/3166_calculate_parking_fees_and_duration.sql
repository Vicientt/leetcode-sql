-- Write your PostgreSQL query statement below
with cal_time_fee as (
    select
        car_id,
        sum(extract(epoch from (exit_time - entry_time)))::numeric/3600 as total_hour,
        sum(fee_paid) as total_fee
    from ParkingTransactions
    group by car_id
), time_lot_per_car as (
    select
        lot_id, car_id, sum(extract(epoch from (exit_time - entry_time))) as total_time
    from ParkingTransactions
    group by lot_id, car_id
), most_time_lot as (
    select *,
    rank() over(partition by car_id order by total_time desc) as ranking
    from time_lot_per_car
)

select
    a.car_id,
    a.total_fee as total_fee_paid,
    round(a.total_fee/a.total_hour,2) as avg_hourly_fee,
    b.lot_id as most_time_lot
from cal_time_fee a
join most_time_lot b on a.car_id = b.car_id
where b.ranking = 1
order by a.car_id;