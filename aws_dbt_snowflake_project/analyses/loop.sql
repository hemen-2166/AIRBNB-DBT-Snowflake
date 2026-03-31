{% set cols = ['listing_id', 'nights_booked', 'Booking_ID', 'Booking_Amount'] %}

Select 
{% for col in cols %}
    {{ col }}
        {% if not loop.last %}, {% endif %}
{% endfor %}
from {{ ref('bronze_bookings') }}