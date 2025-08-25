{{ config(materialized='table') }}


with cpi as (
   select
       date_value,
       consumer_price_index
 from {{ ref('conf_kpi') }}
),
oil as (
   select
       year,
       oil_production_per_year
   from {{ ref('conf_oil_production') }}
),
income as (
   select
       year,
       wage_income_nok
    from {{ ref('conf_mean_income') }}
),
crises as (
   select
       crises_year as crisis_year,
       crisis_event
   from {{ ref('conf_crises') }}
)
select
   c.date_value,
   year(c.date_value) as year,
   c.consumer_price_index,
   o.oil_production_per_year,
   i.wage_income_nok,
   cr.crisis_event
from cpi c
left join oil o
   on year(c.date_value) = o.year
left join income i
   on year(c.date_value) = i.year
left join crises cr
   on year(c.date_value) = cr.crisis_year 