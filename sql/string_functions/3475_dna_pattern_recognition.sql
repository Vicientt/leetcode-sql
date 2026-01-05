-- Write your PostgreSQL query statement below
select *,
    case when left(dna_sequence, 3) = 'ATG' then 1 else 0 end as has_start,
    case when right(dna_sequence, 3) = 'TAA' or right(dna_sequence, 3) = 'TAG' or right(dna_sequence, 3) = 'TGA' then 1 else 0 end as has_stop,
    case when dna_sequence like '%ATAT%' then 1 else 0 end as has_atat,
    case when dna_sequence like '%GGG%' then 1 else 0 end as has_ggg
from Samples;