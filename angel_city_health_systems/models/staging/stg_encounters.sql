
WITH source AS (
    SELECT
        *
    FROM ACHS_PROD_DB.LANDING_SCHEMA.ENCOUNTERS_LND
)

SELECT
    TRIM(RAW_DATA:encounter_id, '"') ENCOUNTER_ID,
    TRIM(RAW_DATA:patient_id, '"') PATIENT_ID,
    TRIM(RAW_DATA:provider_id, '"') PROVIDER_ID,
    TRIM(RAW_DATA:admission_source, '"') ADMISSION_SOURCE,
    TRIM(RAW_DATA:encounterClass, '"') ENOUNTER_CLASS,
    TRIM(RAW_DATA:encounter_start_timestamp, '"') ENCOUNTER_START_TIMESTAMP,
    TRIM(RAW_DATA:encounter_end_timestamp, '"') ENCOUNTER_END_TIMESTAMP,
    SOURCE_FILE,
    FILE_ROW_NUMBER,
    LOADED_AT_TIMESTAMP
FROM source
