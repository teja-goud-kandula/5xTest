
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

with cte as (
select Location , Total_Cases, Total_Deaths, 
ROW_NUMBER() OVER (Partition by Location order by Date desc) as RNUM
from metrics
)
select Location, ((Total_Deaths/ Total_Cases ) * 100 )as Death_Rate
from cte where RNUM = 1
order by 2 desc
