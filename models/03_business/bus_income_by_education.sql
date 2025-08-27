{{ config(materialized='view') }}

select
   year,
   long_edu_people,
   WAGE_INCOME_NOk
from {{ ref('int_education_income_year') }}
order by year