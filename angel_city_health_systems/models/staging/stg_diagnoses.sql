SELECT
    source_file,
    file_row_number,
    loaded_at_timestamp,
    TRIM(raw_data:diagnosis_id, '"') AS diagnosis_id,
    TRIM(raw_data:encounter_id, '"') AS encounter_id,
    TRIM(raw_data:recorded_at_timestamp, '"') AS recorded_at_timestamp,
    TRIM(raw_data:diagnosis_rank, '"') AS diagnoses_rank,
    TRIM(raw_data:icd_10_code, '"') AS icd_10_rank,
    TRIM(raw_data:coding_system, '"') AS coding_system
FROM {{ source('landing', 'DIAGNOSES_LND') }}
WHERE logical_load_date = '{{ var("logical_load_date") }}'
