FROM apache/airflow:2.10.0

# Create an isolated virtual environment for dbt.
# This prevents dbt's heavy dependencies from destroying Airflow's strict constraints and throwing hash errors.
RUN python -m venv dbt_venv && \
    ./dbt_venv/bin/pip install --no-cache-dir --default-timeout=1000 dbt-core dbt-snowflake
