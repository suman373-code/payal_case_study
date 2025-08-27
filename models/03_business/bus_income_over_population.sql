{{ config(materialized='view') }}

select
   year,
   wage_income_nok,
   population
from {{ ref('int_income_over_population') }}
order by year