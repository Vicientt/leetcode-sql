with find_person as (
    select
        a.user_id,
        count(*) as num_rating
    from MovieRating a
    group by a.user_id
), find_movies as (
    select
        a.movie_id,
        avg(a.rating) as average_rating
    from MovieRating a
    where to_char(created_at, 'YYYY-MM') = '2020-02'
    group by a.movie_id
)

(select b.name as results
from find_person a
join Users b on a.user_id = b.user_id
order by a.num_rating desc, b.name
limit 1)

union all

(select b.title as results
from find_movies a
join Movies b on a.movie_id = b.movie_id
order by a.average_rating desc, b.title
limit 1);
