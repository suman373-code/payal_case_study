{{ config(materialized='table') }}
 
with source as (
select
customerkey as customer_key,
customername as customer_name,
TO_DATE(datevalue, 'DD.MM.YYYY') as date_value,
cast(marketvalue as decimal) as market_value_nok
from {{ ref('CustomerAUM') }}
)
 
select
	customer_key,
	customer_name,
	date_value,
	market_value_nok
from source
