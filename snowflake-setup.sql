--select rolee to create the warehouse,database,schema,role and user
USE ROLE ACCOUNTADMIN;
--create warehouse for dbt work
CREATE OR REPLACE WAREHOUSE booking_wh
WITH WAREHOUSE_SIZE = 'XSMALL'
AUTO_RESUME = TRUE
AUTO_SUSPEND = 60
ENABLE_QUERY_ACCELERATION = TRUE
COMMENT = 'Warehouse for booking data processing'
INITIALLY_SUSPENDED = FALSE;

--create database for dbt work
CREATE OR REPLACE DATABASE booking_db
WITH COMMENT = 'Database for booking data processing';

--create schema for dbt work
CREATE OR REPLACE SCHEMA booking_db.booking_schema;

--create role for dbt work
CREATE OR REPLACE ROLE booking_role;

--create user for dbt work
CREATE OR REPLACE USER booking_user
WITH PASSWORD = 'booking_user123'
DEFAULT_ROLE = booking_role
DEFAULT_WAREHOUSE = booking_wh
DEFAULT_NAMESPACE = booking_db.booking_schema
MUST_CHANGE_PASSWORD = FALSE;

--grant permissions to the user
GRANT ROLE booking_role TO ROLE SYSADMIN;
GRANT ROLE booking_role TO ROLE ACCOUNTADMIN;
GRANT ROLE booking_role TO USER booking_user;

--grant permissions to the dbt  role
GRANT USAGE ON WAREHOUSE booking_wh TO ROLE booking_role;
GRANT USAGE ON DATABASE booking_db TO ROLE booking_role;
GRANT USAGE ON SCHEMA booking_db.booking_schema TO ROLE booking_role;
GRANT CREATE TABLE ON SCHEMA booking_db.booking_schema TO ROLE booking_role;
GRANT CREATE VIEW ON SCHEMA booking_db.booking_schema TO ROLE booking_role;
GRANT CREATE STAGE ON SCHEMA booking_db.booking_schema TO ROLE booking_role;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE booking_db TO DBT_ROLE;
GRANT SELECT ON ALL TABLES IN DATABASE booking_db TO DBT_ROLE;
GRANT SELECT ON FUTURE TABLES IN DATABASE booking_db TO DBT_ROLE;
GRANT SELECT ON ALL VIEWS IN DATABASE booking_db TO DBT_ROLE;
GRANT SELECT ON FUTURE VIEWS IN DATABASE booking_db TO DBT_ROLE;
GRANT MANAGE GRANTS ON ACCOUNT TO ROLE DBT_ROLE;

-- Grant permissions to the user on the warehouse, database, and schema
SHOW GRANTS TO USER booking_user;
GRANT USAGE ON WAREHOUSE booking_wh TO USER booking_user;
SHOW GRANTS ON SCHEMA booking_db.booking_schema;