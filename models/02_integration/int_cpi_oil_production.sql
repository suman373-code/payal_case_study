{{ config(materialized='table') }} 

with prev_year_avg_cpi as (
    select 
        cpi_year,
        avg_cpi,
        lag(avg_cpi) over (order by cpi_year) as prev_year_cpi
    from {{ ref('conf_yearly_cpi') }} 
),
prev_year_oil_production as (
    select 
        year,
        oil_production_per_year,
        lag(oil_production_per_year) over (order by year) as prev_year_oil
    from {{ ref('conf_oil_production') }} 
)
select 
    c.cpi_year as year,
    c.avg_cpi,
    c.prev_year_cpi,
    o.oil_production_per_year,
    o.prev_year_oil
from prev_year_avg_cpi c
join prev_year_oil_production o
on c.cpi_year = o.year