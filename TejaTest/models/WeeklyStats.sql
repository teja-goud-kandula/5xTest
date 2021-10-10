
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

with Weekly_Cases as (
select  SUM(New_Cases) OVER(partition by YEAR(TO_DATE(DATE)),WEEKOFYEAR(TO_DATE(Date))) as Weekly_Cases ,
SUM(New_Deaths) OVER(partition by YEAR(TO_DATE(DATE)),WEEKOFYEAR(TO_DATE(Date))) as Weekly_Deaths ,
SUM(New_Recovered) OVER(partition by YEAR(TO_DATE(DATE)),WEEKOFYEAR(TO_DATE(Date))) as Weekly_Recovered ,
SUM(New_Active_Cases) OVER(partition by YEAR(TO_DATE(DATE)),WEEKOFYEAR(TO_DATE(Date))) as Weekly_Active_Cases,
WEEKOFYEAR(TO_DATE(Date)) as WeekNumber,
YEAR(TO_DATE(DATE)) as Year,
ROW_NUMBER() OVER(Partition by YEAR(TO_DATE(DATE)), WEEKOFYEAR(TO_DATE(Date)) order by To_Date(Date) desc) as RNUM
from metrics
where Location IN ('Indonesia')
)
select Weekly_Cases, Weekly_Deaths, Weekly_Recovered, Weekly_Active_Cases, WeekNumber, Year
from Weekly_Cases where RNUM = 1
order by Year, WeekNumber
