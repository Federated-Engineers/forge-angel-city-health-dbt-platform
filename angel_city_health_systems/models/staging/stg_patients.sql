SELECT
    source_file,
    file_row_number,
    loaded_at_timestamp,
    TRIM(raw_data:patient_id, '"') AS patient_id,
    TRIM(raw_data:primary_insurance_id, '"') AS primary_insurance_id,
    TRIM(raw_data:social_security_hash, '"') AS social_security_hash,
    TRIM(raw_data:first_name, '"') AS "first_name",
    TRIM(raw_data:last_name, '"') AS "last_name",
    TRIM(raw_data:date_of_birth, '"') AS date_of_birth,
    TRIM(raw_data:gender_code, '"') AS gender_code,
    TRIM(raw_data:createdAt, '"') AS created_at,
    TRIM(raw_data:contact_info:email, '"') AS "email",
    TRIM(raw_data:contact_info:phone, '"') AS phone,
    TRIM(
        raw_data:contact_info:residential_zip_code, '"'
    ) AS residential_zip_code
FROM {{ source('landing', 'PATIENTS_LND') }}
WHERE logical_load_date = '{{ var("logical_load_date") }}'
