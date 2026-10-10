
WITH source AS (
    SELECT
        *
    FROM ACHS_PROD_DB.LANDING_SCHEMA.DIAGNOSES_LND
)

SELECT
    TRIM(RAW_DATA:diagnosis_id, '"') DIAGNOSIS_ID,
    TRIM(RAW_DATA:encounter_id, '"') ENCOUNTER_ID,
    TRIM(RAW_DATA:recorded_at_timestamp, '"') RECORDED_AT_TIMESTAMP,
    TRIM(RAW_DATA:diagnosis_rank, '"') DIAGNOSES_RANK,
    TRIM(RAW_DATA:icd_10_code, '"') ICD_10_RANK,
    TRIM(RAW_DATA:coding_system, '"') CODING_SYSTEM,
    SOURCE_FILE,
    FILE_ROW_NUMBER,
    LOADED_AT_TIMESTAMP
FROM source
