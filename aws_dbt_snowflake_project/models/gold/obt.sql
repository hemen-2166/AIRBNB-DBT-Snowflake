{% set configs = [
    {
        "table": "AIRBNB.silver.silver_Bookings",
        "Columns": "silver_bookings.booking_id, silver_bookings.booking_date, silver_bookings.total_booking_amount, silver_bookings.booking_status, silver_bookings.created_at as silver_bookings_created_at",
        "alias": "silver_bookings"        
    },
    {
        "table": "AIRBNB.silver.silver_listings",
        "Columns": "silver_listings.listing_id, silver_listings.property_type, silver_listings.room_type, silver_listings.city, silver_listings.country, silver_listings.accommodates, silver_listings.bedrooms, silver_listings.bathrooms, silver_listings.price_per_night, silver_listings.price_per_night_tag, silver_listings.created_at as silver_listings_created_at",
        "alias": "silver_listings",
        "join_condition": "silver_bookings.listing_id = silver_listings.listing_id"        
    },
    {
        "table": "AIRBNB.silver.silver_hosts",
        "Columns": "silver_hosts.host_id, silver_hosts.host_name, silver_hosts.host_since, silver_hosts.is_superhost, silver_hosts.response_rate, silver_hosts.response_rate_tag, silver_hosts.created_at as silver_hosts_created_at",
        "alias": "silver_hosts",
        "join_condition": "silver_listings.host_id = silver_hosts.host_id"        
    }  
]%}

Select {% for item in configs %} 
        {{ item.Columns }} 
            {% if not loop.last %}, {% endif %} 
    {% endfor %}
From
    {% for config in configs %}
        {% if loop.first %}
            {{config['table']}} as {{config['alias']}}
        {% else %}
            left join {{config['table']}} as {{config['alias']}} on {{config['join_condition']}}
        {% endif %}  
    {% endfor %}

    