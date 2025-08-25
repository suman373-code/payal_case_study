{{ config(materialized='table') }} 

with base as (
   select
       customer_key,
       customer_name,
       date_value,
       market_value_nok,
       lag(market_value_nok) over (partition by customer_key order by date_value) as prev_value
   from {{ ref('conf_customer_aum') }}
)
select
   customer_key,
   customer_name,
   date_value,
   market_value_nok,
   case
       when prev_value is not null and prev_value > 0
       then round(((market_value_nok - prev_value) / prev_value) * 100, 2)
   end as pct_change
from base