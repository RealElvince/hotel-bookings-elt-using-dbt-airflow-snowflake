from airflow import DAG
from airflow.operators.python import PythonOperator, BranchPythonOperator
from datetime import datetime, timedelta
from airflow.operators.bash import BashOperator
import os

# Define default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 10, 1),
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
}

#define the DAG
dag = DAG(
    'init_seed_data',
    default_args=default_args,
    description='A DAG to initialize seed data',
    schedule_interval=None,  # Set to None for manual triggering
)

task1 = BashOperator(
    task_id='load_seed_data',
    bash_command='cd /usr/local/airflow/dbt && dbt seed --profiles-dir .',
    env={
            'dbt_user': 'booking_user',
            'dbt_password': 'booking_password123',
            **os.environ
        },
    dag=dag,
)

task1