{{ config(materialized='view') }}

SELECT
    YEAR(Date_Value) AS Year,
    customer_name , 
    SUM(MARKET_VALUE_NOK) AS TotalAUM
FROM 
   {{ ref('conf_customer_aum') }}  
GROUP BY 
    1,2
ORDER BY 
    Year