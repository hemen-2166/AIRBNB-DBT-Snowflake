{{ config(materialized='incremental') }}
{% set incremental_col = 'CREATED_AT' %}

Select * from {{ source('staging', 'listings') }}

{% if is_incremental() %}
    where {{ incremental_col }} > (Select coalesce(max({{ incremental_col }}), '1900-01-01') from {{ this }})
{% endif %}
