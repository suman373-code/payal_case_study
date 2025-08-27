{{ config(materialized='table') }} 

with crisis_cpi AS (
    select
    y.cpi_year ,
    y.avg_cpi,
    c.crisis_name,
    c.crisis_year,
    case 
        when y.cpi_year = c.crisis_year then 'during crisis'
        when y.cpi_year = c.crisis_year - 1 then 'before crisis'
        when y.cpi_year = c.crisis_year + 1 then 'after crisis'
        else 'no crisis'
    end as crisis_flag
    from {{ ref('conf_yearly_cpi') }} y
    join {{ ref('conf_crisis') }}  c
    on y.cpi_year between c.crisis_year - 1 and c.crisis_year + 1
)
select
   cpi_year,
   avg_cpi,
   crisis_name,
   crisis_year,
   crisis_flag
from 
   crisis_cpi