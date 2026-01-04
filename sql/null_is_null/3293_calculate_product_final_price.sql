-- Write your PostgreSQL query statement below

    select
        a.product_id,
        a.price * (100 - coalesce(b.discount,0))::numeric/ 100 as final_price,
        a.category
    from Products a
    left join Discounts b on a.category = b.category
    order by a.product_id
