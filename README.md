# AIRBNB-DBT-Snowflake

## Overview
This repository manages a modern **Data Engineering Pipeline** that extracts, loads, and transforms (ELT) Airbnb data into actionable insights using Snowflake. The core data transformations are executed using dbt (Data Build Tool) and orchestrated entirely locally via Apache Airflow.

## Technology Stack
- **Data Platform**: Snowflake
- **Transformations**: dbt (`dbt-snowflake`)
- **Orchestration**: Apache Airflow (Dockerized via TaskFlow API)
- **Containerization**: Docker & Docker Compose

## Repository Structure
- `aws_dbt_snowflake_project/`: Contains the complete dbt project, encompassing your models (bronze, silver, gold layers), snapshots, and the underlying `profiles.yml` logic.
- `dags/`: Houses the Airflow DAGs (`dbt_snowflake_dag.py`) that trigger and sequence the dbt command-line tasks safely.
- `Dockerfile` & `docker-compose.yaml`: Provisions a custom Airflow image integrating an isolated Python virtual environment specifically tuned to run `dbt` cleanly without package conflicts.
- `AIRFLOW_GUIDE.md`: Detailed documentation on how to spin up the local Airflow cluster and execute the pipeline using Docker Compose.