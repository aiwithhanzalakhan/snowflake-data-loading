USE DATABASE SNOW_SQL;


CREATE OR REPLACE TABLE TESLA_STOCKS(
    date DATE,
    open_value DOUBLE,
    high_vlaue DOUBLE,
    low_value DOUBLE,
    close_vlaue DOUBLE,
    adj_close_value DOUBLE,
    volume BIGINT
);

-- should be empty
SELECT * FROM TESLA_STOCKS;

-- external stage creation
CREATE OR REPLACE STAGE BULK_COPY_TESLA_STOCKS
URL = "s3://snowflake-data-loading/TSLA.csv"
CREDENTIALS = (AWS_KEY_ID='', AWS_SECRET_KEY='');



-- list stage
LIST @BULK_COPY_TESLA_STOCKS;

-- copy data from stage to table
COPY INTO TESLA_STOCKS
	FROM @BULK_COPY_TESLA_STOCKS
	file_format = (TYPE = 'CSV', FIELD_DELIMITER=',', SKIP_HEADER=1)
    on_error = 'skip_file';

-- data should be there
SELECT * FROM TESLA_STOCKS;


