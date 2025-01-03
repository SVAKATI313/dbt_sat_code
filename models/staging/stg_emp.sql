{{config(materialized='table',transient=false)}}

WITH tb1 as (
    select EMPID as ID, 
    EMPNAME AS NAME,
    SALARY as SAL,
    AGE
     from {{source('datafeed_shared_schema','STG_EMPL')}}
)
select * from tb1 