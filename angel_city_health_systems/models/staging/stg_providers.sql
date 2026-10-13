SELECT
    source_file,
    loaded_at_timestamp,
    TRIM(raw_data:facility_id, '"') AS facility_id,
    TRIM(raw_data:hire_date, '"') AS hire_date,
    TRIM(raw_data:is_active, '"') AS is_active,
    TRIM(raw_data:npi_number, '"') AS npi_number,
    TRIM(raw_data:provider_id, '"') AS provider_id,
    TRIM(raw_data:provider_type, '"') AS provider_type,
    TRIM(raw_data:specialty_code, '"') AS speciality_code
FROM achs_prod_db.landing_schema.providers_lnd
