{{ config(materialized='ephemeral') }}

with bookings as (
    Select 
        booking_id, 
        booking_date, 
        booking_status, 
        silver_bookings_created_at
    from {{ ref('obt') }}
)
select * from bookings
