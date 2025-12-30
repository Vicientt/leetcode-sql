with check_include_word as(
    select
        file_name,
        case when lower(content) like '% bull %' then 'bull' end as word_bull,
        case when lower(content) like '% bear %' then 'bear' end as word_bear
    from Files
), count_bull as (
    select
        word_bull as word,
        count(*) as count
    from check_include_word
    group by word_bull
    having word_bull is not null
), count_bear as (
    select
        word_bear as word,
        count(*) as count
    from check_include_word
    group by word_bear
    having word_bear is not null
)

select *
from count_bull

union all

select *
from count_bear;