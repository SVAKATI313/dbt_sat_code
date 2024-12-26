{{ config(materialized='table') }}

with tb1 as 
(select id,
ORDER_DATE,
USER_ID,
STATUS
from {{source('datafeed_shared_schema','raw_order')}})
select * from tb1

