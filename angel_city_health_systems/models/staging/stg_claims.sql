
WITH source AS (
    SELECT
        *
    FROM ACHS_PROD_DB.LANDING_SCHEMA.CLAIMS_LND
)

SELECT
    TRIM(RAW_DATA:claim_id, '"') AS CLAIM_ID,
    TRIM(RAW_DATA:encounter_id, '"') AS ENCOUNTER_ID,
    TRIM(RAW_DATA:payer_id, '"') AS PAYER_ID,
    RAW_DATA:total_billed_amount AS TOTAL_BILLED_AMOUNT,
    RAW_DATA:amount_paid_by_insurance AS AMOUNT_PAID_BY_INSURANCE,
    RAW_DATA:patient_responsibility_amount AS PATIENT_RESPONSIBILITY_AMOUNT,
    CASE
        WHEN TRIM(RAW_DATA:adjudication:denial_reason, '"') IS NOT NULL THEN 'denied'
        ELSE 'accepted'
    END AS CLAIM_STATUS,
    TRIM(RAW_DATA:adjudication:denial_reason, '"') AS ADJUDICATION_DENIAL_REASON,
    TRIM(RAW_DATA:adjudication:processed_date, '"') AS ADJUDICATION_PROCESSED_DATE,
    RAW_DATA:adjudication:reimbursement_rate AS ADJUDICATION_REIMBURSMENT_RATE
FROM source
