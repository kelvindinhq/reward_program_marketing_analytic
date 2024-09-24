
-- CREATE DATABASE
IF DB_ID('bogo_marketing') IS NULL
    CREATE DATABASE bogo_marketing;

-- SWITCH TO bogo_marketing database
USE bogo_marketing;

ALTER DATABASE bogo_marketing COLLATE Latin1_General_100_CI_AI_SC_UTF8;

CREATE SCHEMA bronze
GO

CREATE SCHEMA silver
GO

CREATE SCHEMA gold
GO

CREATE EXTERNAL DATA SOURCE ws_container_bogo_marketing
WITH(
    LOCATION = 'https://bogomarketingdl.dfs.core.windows.net/ws-container/'
);
CREATE EXTERNAL DATA SOURCE ws_container_bogo_marketing_raw
WITH(
    LOCATION = 'https://bogomarketingdl.dfs.core.windows.net/ws-container/raw'
);

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'parquet_file_format')
    CREATE EXTERNAL FILE FORMAT parquet_file_format
    WITH (
        FORMAT_TYPE = PARQUET,
        DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
    );