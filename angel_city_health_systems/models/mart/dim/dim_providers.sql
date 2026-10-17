{{
    config(
        materialized='incremental',
        incremental_strategy='insert_overwrite',
    )
}}

SELECT
    source_file,
    loaded_at_timestamp,
    facility_id,
    hire_date,
    is_active,
    npi_number,
    provider_id,
    provider_type,
    speciality_code
FROM {{ ref('stg_providers') }}
