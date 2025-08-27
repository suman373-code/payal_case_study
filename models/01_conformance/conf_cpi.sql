{{ config(materialized='table') }}
 
with source as (
select
TO_DATE(date, 'DD.MM.YYYY') as cpi_date,
cast(CONSUMERPRICEINDEX as numeric) as consumer_price_index
from {{ ref('Cpi') }}
)
 
select * from source
