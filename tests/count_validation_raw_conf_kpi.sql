with raw_count as (
select count(*) as c1 
from {{ ref('Cpi') }}
),
conf_count as (
select count(*) as c2
from {{ ref('conf_cpi') }}
)
select 
    raw_count.c1,
    conf_count.c2
from raw_count, conf_count
where raw_count.c1 != conf_count.c2
