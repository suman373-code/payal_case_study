{{ config(materialized='table') }}
 
with source as (
select
TO_DATE(date, 'DD.MM.YYYY') as date_value,
cast(CONSUMERPRICEINDEX as numeric) as consumer_price_index
from {{ ref('kpi') }}
)
 
select * from source
