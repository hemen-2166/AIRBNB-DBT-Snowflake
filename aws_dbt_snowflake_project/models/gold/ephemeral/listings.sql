{{ config(materialized='ephemeral') }}

with listings as (
    Select 
        listing_id, 
        PROPERTY_TYPE,
        CITY,
        COUNTRY,    
        price_per_night_tag,
        silver_listings_created_at
    from {{ ref('obt') }}
)
select * from listings