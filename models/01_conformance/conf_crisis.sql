{{ config(materialized='table') }}
 
with source as (
select
cast(year as integer) as crisis_year,
event as crisis_name
from {{ ref('Crises') }}
)
 
select
	crisis_year,
	crisis_name
from source
