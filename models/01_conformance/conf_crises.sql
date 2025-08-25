{{ config(materialized='table') }}
 
with source as (
select
cast(year as integer) as crises_year,
event as crisis_event
from {{ ref('Crises') }}
)
 
select
	crises_year,
	crisis_event
from source
