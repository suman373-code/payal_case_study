{{ config(materialized='table') }} 

with income_over_increased_higher_education as (
    select 
        loe.year as loe_year ,
        loe.short_edu_people , 
        loe.long_edu_people ,
        mi.year as mi_year,
        mi.wage_income_nok
    from {{ ref('conf_level_of_education') }} as loe
    join
    {{ ref('conf_mean_income') }} as  mi
    on loe.year = mi.year
)
select
   loe_year as year,
   short_edu_people,
   long_edu_people,
   wage_income_nok
from 
   income_over_increased_higher_education