{{
    config(
        materialized='incremental',
        incremental_strategy='insert+overwrite'
    )
}}

select * from {{source('datafeed_shared_schema','raw_order')}}