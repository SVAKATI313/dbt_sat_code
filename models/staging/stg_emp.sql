{{config(materialized='view')}}

WITH tb1 as (
    select EMPID as ID, 
    EMPNAME AS NAME
     from {{source('datafeed_shared_schema','STG_EMPL')}}
)
select * from tb1 