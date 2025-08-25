{{ config(materialized='table') }}
with source as (
   select
       cast(year as integer) as year,
       oil_production as oil_production_per_year
from {{ ref('OilProduction') }}
)
select *
from source
