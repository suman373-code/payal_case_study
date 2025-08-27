{{ config(materialized='table') }} 

with income_over_population as (
    select 
        mi.Year,
        mi.wage_income_nok,
        np.population
    from {{ ref('conf_mean_income') }} as mi
    join
    {{ ref('conf_norwegian_population') }} as  np
    on mi.year = np.year
)
select
   year,
   wage_income_nok,
   population
from 
   income_over_population