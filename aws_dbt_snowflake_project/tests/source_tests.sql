{{config(severity='warn')}}

Select 1
from {{ source('staging', 'bookings') }}
Where BOOKING_AMOUNT < 200