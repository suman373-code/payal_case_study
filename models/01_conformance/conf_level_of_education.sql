{{ config(materialized='table') }}
 
with source as (
select
    YEAR ,
    UNIVERSITY_COLLEGE_SHORT as short_edu_people ,
    UNIVERSITY_COLLEGE_LONG as long_edu_people
from {{ ref('LevelOfEducation') }}
)
select * from source