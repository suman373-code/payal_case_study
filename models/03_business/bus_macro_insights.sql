{{ config(materialized='table') }}

select
   date_value,
   year,
   consumer_price_index,
   oil_production_per_year,
   wage_income_nok,
   crisis_event
from {{ ref('int_macro_context') }}
order by date_value