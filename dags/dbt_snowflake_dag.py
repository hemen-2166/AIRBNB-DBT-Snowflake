import os
from datetime import datetime

from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator

DEFAULT_ARGS = {
    "owner": "airflow",
    "retries": 1,
}

# The path to the dbt project inside the Airflow container
DBT_PROJECT_PATH = f"{os.environ.get('AIRFLOW_HOME', '/opt/airflow')}/dags/dbt/aws_dbt_snowflake_project"
# The path where profiles.yml is located
DBT_PROFILES_DIR = DBT_PROJECT_PATH

@dag(
    dag_id="dbt_snowflake_bash_dag",
    default_args=DEFAULT_ARGS,
    start_date=datetime(2023, 1, 1),
    schedule_interval="@daily",
    catchup=False,
    tags=["dbt", "snowflake", "bash", "taskflow"],
)
def dbt_snowflake_pipeline():
    """
    Orchestrates the DBT Snowflake pipeline using Airflow's TaskFlow API.
    """

    start = EmptyOperator(task_id="start")
    end = EmptyOperator(task_id="end")

    @task.bash(task_id="dbt_run")
    def run_models() -> str:
        return f"/opt/airflow/dbt_venv/bin/dbt run --project-dir {DBT_PROJECT_PATH} --profiles-dir {DBT_PROFILES_DIR}"

    @task.bash(task_id="dbt_test")
    def test_models() -> str:
        return f"/opt/airflow/dbt_venv/bin/dbt test --project-dir {DBT_PROJECT_PATH} --profiles-dir {DBT_PROFILES_DIR}"

    # Set dependencies
    start >> run_models() >> test_models() >> end

# Invoke the DAG
dbt_snowflake_pipeline()
