# Use the latest Airflow image with Python 3.12
FROM apache/airflow:2.8.0-python3.12

# Set the working directory
WORKDIR /usr/local/airflow

# Copy the requirements file into the container
COPY requirements.txt .

# check of the requirements file was copied correctly
RUN ls -al /usr/local/airflow

# install the required python packages from the requirements file
RUN pip install --no-cache-dir -r requirements.txt

# check if the packages were installed correctly
RUN pip list