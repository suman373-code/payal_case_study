{{ config(materialized='view') }}

select 
    year,
    avg_cpi,
    prev_year_cpi,
    oil_production_per_year,
    prev_year_oil
from {{ ref('int_cpi_oil_production') }}
where prev_year_cpi is not null
and prev_year_oil is not null
and avg_cpi > prev_year_cpi
order by year
