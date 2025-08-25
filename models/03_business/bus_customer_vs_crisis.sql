{{ config(materialized='table') }} 


with trends as (
   select
       customer_key,
       customer_name,
       date_value,
       market_value_nok,
       pct_change
    from {{ ref('int_customer_trends') }}
),
crises as (
   select
       crises_year as crisis_year,
       crisis_event
   from {{ ref('conf_crises') }}
  
)
select
   t.customer_key,
   t.customer_name,
   t.date_value,
   year(t.date_value) as year,
   t.market_value_nok,
   t.pct_change,
   cr.crisis_event
from trends t
left join crises cr
   on year(t.date_value) = cr.crisis_year
order by t.customer_key, t.date_value