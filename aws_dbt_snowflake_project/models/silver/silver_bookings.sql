{{ config(materialized='incremental', unique_key='BOOKING_ID') }}

Select 
BOOKING_ID, 
listing_id, 
BOOKING_DATE, 
NIGHTS_BOOKED,
BOOKING_AMOUNT,
{{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2) }} as TOTAL_BOOKING_AMOUNT,
BOOKING_STATUS, 
CREATED_AT
From {{ ref('bronze_bookings') }}