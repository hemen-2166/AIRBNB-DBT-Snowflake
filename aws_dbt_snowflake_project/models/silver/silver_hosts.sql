{{ config(materialized='incremental', unique_key='HOST_ID') }}


Select HOST_ID,
Replace(HOST_NAME, ' ', '_') as HOST_NAME,
HOST_SINCE As HOST_SINCE,
IS_SUPERHOST As IS_SUPERHOST,
RESPONSE_RATE As RESPONSE_RATE,
case 
When RESPONSE_RATE > 95 then 'VERY GOOD'
When RESPONSE_RATE > 80 then 'GOOD'
When RESPONSE_RATE > 60 then 'FAIR'
else 'POOR'
end as RESPONSE_RATE_TAG,   
CREATED_AT
from {{ ref('bronze_hosts') }}
