
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


select distinct(location), case when Location_Level = 'Province' THEN 1 ELSE 0 END as IsProvince
from {{ source('google_sheets_src','COVID_19_INDONESIA_teja_kandula') }} 
