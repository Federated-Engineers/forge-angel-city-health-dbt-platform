SELECT
    TRIM(raw_data:claim_id, '"') AS claim_id,
    TRIM(raw_data:encounter_id, '"') AS encounter_id,
    TRIM(raw_data:payer_id, '"') AS payer_id,
    raw_data:total_billed_amount AS total_billed_amount,
    raw_data:amount_paid_by_insurance AS amount_paid_by_insurance,
    raw_data:patient_responsibility_amount AS patient_responsibility_amount,
    CASE
        WHEN
            TRIM(raw_data:adjudication:denial_reason, '"') IS NOT NULL
            THEN 'denied'
        ELSE 'accepted'
    END AS claim_status,
    TRIM(
        raw_data:adjudication:denial_reason, '"'
    ) AS adjudication_denial_reason,
    TRIM(
        raw_data:adjudication:processed_date, '"'
    ) AS adjudication_processed_date,
    raw_data:adjudication:reimbursement_rate AS adjudication_reimbursment_rate
FROM {{ source('landing', 'CLAIMS_LND') }}
WHERE logical_load_date = '{{ var("logical_load_date") }}'
