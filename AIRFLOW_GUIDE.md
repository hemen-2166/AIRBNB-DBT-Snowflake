# Running Airflow Locally with Docker

This guide explains how to start, interact with, and stop the local Apache Airflow environment that runs your DBT Snowflake DAG.

## Prerequisites
- **Docker Desktop** installed and running on your machine.

## 1. Initializing the Airflow Database (First Time Only)
Before starting Airflow for the very first time, you must initialize its internal metadata database and run migrations.
Open a terminal in the root of the project (where `docker-compose.yaml` is located) and run:
```bash
docker compose up airflow-init
```
Wait for this process to finish. It will create the default `airflow` user and set up the metadata database. The process will gracefully exit with a message like `airflow-init-1 exited with code 0` once complete.

## 2. Starting the Services
To spin up all Airflow services (Webserver, Scheduler, Worker, Postgres DB, and Redis), run the following command in detached mode:
```bash
docker compose up -d
```
*(Note: It may take a minute or two for all services to become fully healthy on the first run as it builds the custom Docker image locally).*

## 3. Accessing the Airflow UI
Once the containers are running and healthy, you can access the Airflow web interface:
1. Open your web browser and navigate to **[http://localhost:8080](http://localhost:8080)**.
2. Log in using the default local credentials:
   - **Username**: `airflow`
   - **Password**: `airflow`

## 4. Running the DBT Pipeline
In the Airflow UI:
1. Locate the `dbt_snowflake_bash_dag` DAG in the list.
2. **Unpause** the DAG by clicking the toggle button on the left side of its name.
3. Trigger it manually by clicking the **"Play" button** on the right side of the screen and selecting "Trigger DAG".
4. You can click into the DAG and check the Grid/Graph views. Click on the individual tasks (`dbt_run` and `dbt_test`) and open the **Logs** tab to see your models compiling and executing against Snowflake in real-time.

## 5. Stopping the Environment
When you are done testing, you should stop the containers to free up your system's CPU and memory:
```bash
docker compose down
```

### Complete Reset (Optional)
If you ever want to completely wipe the Airflow database (deleting run history) and start fresh from scratch, run:
```bash
docker compose down --volumes --remove-orphans
```
