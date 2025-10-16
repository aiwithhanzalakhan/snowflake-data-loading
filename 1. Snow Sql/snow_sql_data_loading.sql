-- Create Data Base
CREATE DATABASE SNOW_SQL;

-- Use Data Base
USE DATABASE SNOW_SQL;

-- Create Table
CREATE TABLE CUSTOMER_DETAILS (
    first_name STRING,
    last_name STRING,
    address STRING,
    city STRING,
    state STRING
);


SELECT * FROM CUSTOMER_DETAILS;


-- Create File format
CREATE OR REPLACE FILE FORMAT FILE_FORMAT_CLI
	type = 'CSV'
	field_delimiter = '|'
	skip_header = 1;

-- Create Stage
CREATE OR REPLACE STAGE SNOW_SQL_CLI_STAGE
	file_format = FILE_FORMAT_CLI;	


DESC STAGE SNOW_SQL_CLI_STAGE;

PUT 'file:///C:/Users/abc/Desktop/Snowflake weather warehousing/customer_detail.csv'
    @SNOW_SQL_CLI_STAGE
    AUTO_COMPRESS = TRUE;

COPY INTO CUSTOMER_DETAILS
	FROM @SNOW_SQL_CLI_STAGE
	file_format = (format_name = FILE_FORMAT_CLI)
	on_error = 'skip_file';


SELECT * FROM CUSTOMER_DETAILS;