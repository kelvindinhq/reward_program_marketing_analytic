USE bogo_marketing
GO

DROP VIEW IF EXISTS bronze.vw_offer_type
GO

CREATE VIEW bronze.vw_offer_type
AS
    SELECT 
    reward,
    JSON_VALUE(channels, '$[0]') AS channel_1,
    JSON_VALUE(channels, '$[1]') AS channel_2,
    JSON_VALUE(channels, '$[2]') AS channel_3,
    JSON_VALUE(channels, '$[3]') AS channel_4,
    difficulty,
    duration,
    offer_type,
    id
FROM OPENROWSET(
        BULK 'portfolio.json',
        DATA_SOURCE= 'ws_container_bogo_marketing_raw',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonDoc Nvarchar(MAX)
    ) AS offer_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
    reward SMALLINT,
    channels NVARCHAR(MAX) AS JSON,
    difficulty SMALLINT,
    duration DECIMAL(5, 2),
    offer_type VARCHAR(30),
    id VARCHAR(50)
    )
GO

-- SELECT * FROM bronze.vw_offer_type
-- GO

DROP VIEW IF EXISTS bronze.vw_customer_profile
GO

CREATE VIEW bronze.vw_customer_profile
AS
SELECT 
    gender,
    age,
    id,
    became_member_on,
    income
FROM OPENROWSET(
        BULK 'profile.json',
        DATA_SOURCE= 'ws_container_bogo_marketing_raw',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonDoc Nvarchar(MAX)
    ) AS customer_profile
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
    gender VARCHAR(1),
    age SMALLINT,
    id VARCHAR(50),
    became_member_on DATE,
    income INT
      )
GO

SELECT * FROM bronze.vw_customer_profile
GO

DROP VIEW IF EXISTS bronze.vw_transaction
GO

CREATE VIEW bronze.vw_transaction
AS
SELECT 
    person,
    event,
    amount,
    time
FROM OPENROWSET(
        BULK 'transcript.json',
        DATA_SOURCE= 'ws_container_bogo_marketing_raw',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonDoc Nvarchar(MAX)
    ) AS transcript
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
    person VARCHAR(50),
    event VARCHAR(30),
    value NVARCHAR(MAX) AS JSON,
    time INT
      )
    CROSS APPLY OPENJSON(value)
    WITH(
    amount DECIMAL(7,2)
      )
    WHERE event = 'transaction'
GO

SELECT TOP 1000 * FROM bronze.vw_transaction
GO

DROP VIEW IF EXISTS bronze.vw_offer_received
GO

CREATE VIEW bronze.vw_offer_received
AS
SELECT 
    person,
    event,
    offer_id,
    time
FROM OPENROWSET(
        BULK 'transcript.json',
        DATA_SOURCE= 'ws_container_bogo_marketing_raw',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonDoc Nvarchar(MAX)
    ) AS transcript
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
    person VARCHAR(50),
    event VARCHAR(30),
    value NVARCHAR(MAX) AS JSON,
    time INT
      )
    CROSS APPLY OPENJSON(value)
    WITH(
    offer_id VARCHAR(50) '$."offer id"'
      )
    WHERE event = 'offer received'
GO

SELECT TOP 1000 * FROM bronze.vw_offer_received
GO

DROP VIEW IF EXISTS bronze.vw_offer_viewed
GO

CREATE VIEW bronze.vw_offer_viewed
AS
SELECT 
    person,
    event,
    offer_id,
    time
FROM OPENROWSET(
        BULK 'transcript.json',
        DATA_SOURCE= 'ws_container_bogo_marketing_raw',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonDoc Nvarchar(MAX)
    ) AS transcript
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
    person VARCHAR(50),
    event VARCHAR(30),
    value NVARCHAR(MAX) AS JSON,
    time INT
      )
    CROSS APPLY OPENJSON(value)
    WITH(
    offer_id VARCHAR(50) '$."offer id"'
      )
    WHERE event = 'offer viewed'
GO

SELECT TOP 1000 * FROM bronze.vw_offer_viewed
GO

DROP VIEW IF EXISTS bronze.vw_offer_completed
GO

CREATE VIEW bronze.vw_offer_completed
AS
SELECT 
    person,
    event,
    offer_id,
    reward,
    time
FROM OPENROWSET(
        BULK 'transcript.json',
        DATA_SOURCE= 'ws_container_bogo_marketing_raw',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonDoc Nvarchar(MAX)
    ) AS transcript
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
    person VARCHAR(50),
    event VARCHAR(30),
    value NVARCHAR(MAX) AS JSON,
    time INT
      )
    CROSS APPLY OPENJSON(value)
    WITH(
    offer_id VARCHAR(50) '$."offer_id"',
    reward SMALLINT
      )
    WHERE event = 'offer completed'
GO

SELECT TOP 1000 * FROM bronze.vw_offer_completed
GO

