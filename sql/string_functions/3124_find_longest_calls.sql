-- Write your PostgreSQL query statement below
with rank_type as (
    select *,
    rank() over (partition by type order by duration desc) as ranking
    from Calls
)

select
    a.first_name,
    b.type,
    LPAD((b.duration/3600)::text,2,'0') || ':' || LPAD(((b.duration%3600)/60)::text,2,'0') || ':' || LPAD((b.duration%60)::text,2,'0') as duration_formatted
from Contacts a
join rank_type b on a.id = b.contact_id
where b.ranking <= 3
order by type desc, duration desc, first_name desc;

