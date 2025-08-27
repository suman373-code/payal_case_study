{{ config(materialized='table') }}

with source as (
   select
       cast(year as integer) as year,
       population_january1 as population
  from {{ ref('NorwegianPopulation') }}
)
select *
from source