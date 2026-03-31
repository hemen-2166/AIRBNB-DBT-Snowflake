{% set configs = [
    {
        "table": "AIRBNB.gold.obt",
        "Columns": "GOLD_obt.booking_id, GOLD_obt.listing_id, GOLD_obt.host_id, GOLD_obt.total_booking_amount, GOLD_obt.accommodates, GOLD_obt.bedrooms, GOLD_obt.bathrooms, GOLD_obt.price_per_night, GOLD_obt.response_rate",
        "alias": "GOLD_obt"        
    },
    {
        "table": "AIRBNB.silver.silver_listings",
        "Columns": "",
        "alias": "silver_listings",
        "join_condition": "gold_obt.listing_id = silver_listings.listing_id"        
    },
    {
        "table": "AIRBNB.silver.silver_hosts",
        "Columns": "",
        "alias": "silver_hosts",
        "join_condition": "gold_obt.host_id = silver_hosts.host_id"        
    }  
]%}

Select {{ configs[0]['Columns'] }}
From
    {% for config in configs %}
        {% if loop.first %}
            {{config['table']}} as {{config['alias']}}
        {% else %}
            left join {{config['table']}} as {{config['alias']}} on {{config['join_condition']}}
        {% endif %}  
    {% endfor %}

    