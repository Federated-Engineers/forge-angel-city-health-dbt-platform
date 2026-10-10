
WITH source AS (
    SELECT
        *
    FROM ACHS_PROD_DB.LANDING_SCHEMA.PROVIDERS_LND
)

SELECT
    TRIM(RAW_DATA:facility_id, '"') AS FACILITY_ID,
    TRIM(RAW_DATA:hire_date, '"') AS HIRE_DATE,
    TRIM(RAW_DATA:is_active, '"') AS IS_ACTIVE,
    TRIM(RAW_DATA:npi_number, '"') AS NPI_NUMBER,
    TRIM(RAW_DATA:provider_id, '"') AS PROVIDER_ID,
    TRIM(RAW_DATA:provider_type, '"') AS PROVIDER_TYPE,
    TRIM(RAW_DATA:specialty_code, '"') AS SPECIALITY_CODE,
    SOURCE_FILE,
    LOADED_AT_TIMESTAMP
FROM source
