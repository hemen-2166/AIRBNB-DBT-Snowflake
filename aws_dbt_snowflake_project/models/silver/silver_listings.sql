{{ config(materialized='incremental', unique_key='LISTING_ID') }}

Select LISTING_ID,
HOST_ID,
PROPERTY_TYPE,
ROOM_TYPE,
CITY,
COUNTRY,
ACCOMMODATES,
BEDROOMS,
BATHROOMS,
PRICE_PER_NIGHT,
{{tag('CAST(PRICE_PER_NIGHT as int)')}} as price_per_night_tag,
CREATED_AT
from {{ ref('bronze_listings') }}
