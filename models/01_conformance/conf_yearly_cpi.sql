{{ config(materialized='table') }}

WITH yearly_cpi AS (
    SELECT
        YEAR(cpi_date) AS cpi_year,
        AVG(consumer_price_index) AS avg_cpi
    from {{ ref('conf_cpi') }}
    GROUP BY YEAR(cpi_date)
)
select
 cpi_year,
 avg_cpi
from yearly_cpi