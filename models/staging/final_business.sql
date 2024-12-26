{{
    config(
        materialized='table',
        transient=false
    )
}}

with customers as (
    select 
    ID as customer_id,
    FIRST_NAME,
    LAST_NAME
    from {{ref('stg_customers')}}
),

orders as (
    select 
    id as order_id,
    USER_ID as customer_id,
    ORDER_DATE,
    STATUS
    from {{ref('stg_order')}}
),

customer_orders as(
    select 
    customer_id,
    min (ORDER_DATE) as first_order_date,
    max (ORDER_DATE) as most_recent_order_date,
    count (order_id) as number_of_orders
    from orders
    group by 1

),

final as (
    select 
    customers.customer_id,
    customers.FIRST_NAME,
    customers.LAST_NAME,
    coalesce (customer_orders.number_of_orders,0)  as number_of_orders
    from customers
    left join customer_orders on
    customers.customer_id = customer_orders. customer_id
)

select * from final