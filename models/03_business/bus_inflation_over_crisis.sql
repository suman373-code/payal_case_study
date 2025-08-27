{{ config(materialized='view') }}

select
    crisis_name,
    crisis_year as crisis_year,
    crisis_name||' - '||crisis_year as crisis,
    max(case when crisis_flag = 'before crisis' then avg_cpi end) as cpi_before,
    max(case when crisis_flag = 'during crisis' then avg_cpi end) as cpi_during,
    max(case when crisis_flag = 'after crisis' then avg_cpi end) as cpi_after,
    -- % increase during crisis compared to during crisis
    round(
        100.0 * (max(case when crisis_flag = 'during crisis' then avg_cpi end) -
                 max(case when crisis_flag = 'before crisis' then avg_cpi end)) /
                 max(case when crisis_flag = 'before crisis' then avg_cpi end), 2
    ) as percent_increase_during_crisis,
     -- % increase after crisis compared to during crisis
        round(
        100.0 * (max(case when crisis_flag = 'after crisis' then avg_cpi end) -
                 max(case when crisis_flag = 'during crisis' then avg_cpi end)) /
                 max(case when crisis_flag = 'during crisis' then avg_cpi end), 2
    ) as percent_increase_after_crisis
from {{ ref('int_cpi_crisis') }}
group by crisis_name, crisis_year,crisis
order by crisis_year 