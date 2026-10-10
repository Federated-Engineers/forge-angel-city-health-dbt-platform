
WITH source AS (
    SELECT
        *
    FROM ACHS_PROD_DB.LANDING_SCHEMA.PATIENTS_LND
)

SELECT
    TRIM(RAW_DATA:patient_id, '"') PATIENT_ID,
    TRIM(RAW_DATA:primary_insurance_id, '"') PRIMARY_INSURANCE_ID,
    TRIM(RAW_DATA:social_security_hash, '"') SOCIAL_SECURITY_HASH,
    TRIM(RAW_DATA:first_name, '"') FIRST_NAME,
    TRIM(RAW_DATA:last_name, '"') LAST_NAME,
    TRIM(RAW_DATA:date_of_birth, '"') DATE_OF_BIRTH,
    TRIM(RAW_DATA:gender_code, '"') GENDER_CODE,
    TRIM(RAW_DATA:createdAt, '"') CREATED_AT,
    TRIM(RAW_DATA:contact_info:email, '"') EMAIL,
    TRIM(RAW_DATA:contact_info:phone, '"') PHONE,
    TRIM(RAW_DATA:contact_info:residential_zip_code, '"') RESIDIENTIAL_ZIP_CODE,
    SOURCE_FILE,
    FILE_ROW_NUMBER,
    LOADED_AT_TIMESTAMP
FROM source
