USE bogo_marketing
GO

IF OBJECT_ID('silver.offer_type') IS NOT NULL
    DROP EXTERNAL TABLE silver.offer_type
GO

CREATE EXTERNAL TABLE silver.offer_type
    WITH
    (
        DATA_SOURCE = ws_container_bogo_marketing,
        LOCATION = 'silver/offer_type',
        FILE_format = parquet_file_format
    )
AS
SELECT * FROM bronze.vw_offer_type

SELECT * FROM silver.offer_type

IF OBJECT_ID('silver.customer_profile') IS NOT NULL
    DROP EXTERNAL TABLE silver.customer_profile
GO

CREATE EXTERNAL TABLE silver.customer_profile
    WITH
    (
        DATA_SOURCE = ws_container_bogo_marketing,
        LOCATION = 'silver/customer_profile',
        FILE_format = parquet_file_format
    )
AS
SELECT * FROM bronze.vw_customer_profile

SELECT *FROM silver.customer_profile


IF OBJECT_ID('silver.offer_completed') IS NOT NULL
    DROP EXTERNAL TABLE silver.offer_completed
GO

CREATE EXTERNAL TABLE silver.offer_completed
    WITH
    (
        DATA_SOURCE = ws_container_bogo_marketing,
        LOCATION = 'silver/offer_completed',
        FILE_format = parquet_file_format
    )
AS
SELECT * FROM bronze.vw_offer_completed



IF OBJECT_ID('silver.offer_received') IS NOT NULL
    DROP EXTERNAL TABLE silver.offer_received
GO

CREATE EXTERNAL TABLE silver.offer_received
    WITH
    (
        DATA_SOURCE = ws_container_bogo_marketing,
        LOCATION = 'silver/offer_received',
        FILE_format = parquet_file_format
    )
AS
SELECT * FROM bronze.vw_offer_received


IF OBJECT_ID('silver.offer_viewed') IS NOT NULL
    DROP EXTERNAL TABLE silver.offer_viewed
GO

CREATE EXTERNAL TABLE silver.offer_viewed
    WITH
    (
        DATA_SOURCE = ws_container_bogo_marketing,
        LOCATION = 'silver/offer_viewed',
        FILE_format = parquet_file_format
    )
AS
SELECT * FROM bronze.vw_offer_viewed

IF OBJECT_ID('silver.transactions') IS NOT NULL
    DROP EXTERNAL TABLE silver.transactions
GO

CREATE EXTERNAL TABLE silver.transactions
    WITH
    (
        DATA_SOURCE = ws_container_bogo_marketing,
        LOCATION = 'silver/transaction',
        FILE_format = parquet_file_format
    )
AS
SELECT * FROM bronze.vw_transaction






















