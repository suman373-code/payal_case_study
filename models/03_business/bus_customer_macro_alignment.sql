{{ config(materialized='table') }}

with customer as (
   select
       customer_key,
       customer_name,
       date_value,
       market_value_nok,
       pct_change
   from {{ ref('int_customer_trends') }}
 
),
macro as (
   select
       date_value,
       consumer_price_index,
       oil_production_per_year,
       wage_income_nok,
       crisis_event
   from {{ ref('int_macro_context') }}

)
select
   c.customer_key,
   c.customer_name,
   c.date_value,
   c.market_value_nok,
   c.pct_change,
   m.consumer_price_index,
   m.oil_production_per_year,
   m.wage_income_nok,
   m.crisis_event
from customer c
left join macro m
   on c.date_value = m.date_value
order by c.customer_key, c.date_value 