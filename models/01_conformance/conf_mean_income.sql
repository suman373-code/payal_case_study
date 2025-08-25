{{ config(materialized='table') }}

with source as (
   select
       cast(year as integer) as year,
       cast(Income as numeric) * 1000 as wage_income_nok
  from {{ ref('MeanIncome') }}
   where UNIT  like 'Wage income%'
)
select *
from source
