
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


select distinct(location), LOCATION_ISO_CODE, Province, Island
, Longitude, Latitude, time_zone, Special_Status 
from {{ source('google_sheets_src','COVID_19_INDONESIA_teja_kandula') }} 
