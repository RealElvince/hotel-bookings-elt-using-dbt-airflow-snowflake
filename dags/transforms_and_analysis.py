from datetime import datetime
import os

from airflow import DAG
from airflow.operators.python import PythonOperator, BranchPythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime


default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2020,8,1),
    'retries': 0
}

dag = DAG('2_daily_transformation_analysis', 
    default_args=default_args, 
    schedule_interval='@once'
)

task_1 = BashOperator(
        task_id='daily_transform',
        bash_command='cd /usr/local/airflow/dbt && dbt run --models transform --profiles-dir .',
        env={
            'dbt_user': 'booking_user',
            'dbt_password': 'booking_password123',
            **os.environ
        },
        dag=dag
    )

task_2 = BashOperator(
        task_id='daily_analysis',
        bash_command='cd /usr/local/airflow/dbt && dbt run --models analysis --profiles-dir .',
        env={
            'dbt_user': 'booking_user',
            'dbt_password': 'booking_password123',
            **os.environ
        },
        dag=dag
    )

task_1 >> task_2 # Define dependencies