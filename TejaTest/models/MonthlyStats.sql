
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/


{{ config(materialized='table') }}

with Monthly_Cases as (
select  SUM(New_Cases) OVER(partition by YEAR(TO_DATE(DATE)),MONTH(TO_DATE(Date))) as Monthly_Cases ,
SUM(New_Deaths) OVER(partition by YEAR(TO_DATE(DATE)),MONTH(TO_DATE(Date))) as Monthly_Deaths ,
SUM(New_Recovered) OVER(partition by YEAR(TO_DATE(DATE)),MONTH(TO_DATE(Date))) as Monthly_Recovered ,
SUM(New_Active_Cases) OVER(partition by YEAR(TO_DATE(DATE)),MONTH(TO_DATE(Date))) as Monthly_Active_Cases,
MONTH(TO_DATE(Date)) as Month,
YEAR(TO_DATE(DATE)) as Year,
ROW_NUMBER() OVER(Partition by YEAR(TO_DATE(DATE)), MONTH(TO_DATE(Date)) order by To_Date(Date) desc) as RNUM
from metrics
where Location IN ('Indonesia')
)
select Monthly_Cases, Monthly_Deaths, Monthly_Recovered, Monthly_Active_Cases, Month, Year
from Monthly_Cases where RNUM = 1
order by Year, Month
