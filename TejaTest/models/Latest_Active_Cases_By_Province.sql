
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
select m.date, p.location as Province, m.Total_Active_Cases ,
ROW_NUMBER() OVER(Partition by p.location order by TO_DATE(m.date) desc) as RNUM
from metrics m
JOIN provinces p ON p.location = m.location 
where p.IsProvince = 1
)
select date, Province, Total_Active_Cases
from cte 
where RNUM = 1