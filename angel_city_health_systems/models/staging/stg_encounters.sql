SELECT
    source_file,
    file_row_number,
    loaded_at_timestamp,
    TRIM(raw_data:encounter_id, '"') AS encounter_id,
    TRIM(raw_data:patient_id, '"') AS patient_id,
    TRIM(raw_data:provider_id, '"') AS provider_id,
    TRIM(raw_data:admission_source, '"') AS admission_source,
    TRIM(raw_data:encounterClass, '"') AS enounter_class,
    TRIM(raw_data:encounter_start_timestamp, '"') AS encounter_start_timestamp,
    TRIM(raw_data:encounter_end_timestamp, '"') AS encounter_end_timestamp
FROM achs_prod_db.landing_schema.encounters_lnd
