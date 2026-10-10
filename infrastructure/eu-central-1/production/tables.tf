resource "snowflake_table" "claims_lnd_table" {
  database = module.achs_production_database.snowflake_database_name
  schema   = module.achs_prod_landing_schema.snowflake_schema_name
  name     = "CLAIMS_LND"
  comment  = "Landing table for claims data"

  column {
    name = "RAW_DATA"
    type = "variant"
  }

  column {
    name     = "SOURCE_FILE"
    type     = "text"
    nullable = false
  }

  column {
    name     = "FILE_ROW_NUMBER"
    type     = "bigint"
    nullable = false
  }

  column {
    name     = "LOADED_AT_TIMESTAMP"
    type     = "timestamp_ntz"
    nullable = false
  }
}

resource "snowflake_table" "diagnoses_lnd_table" {
  database = module.achs_production_database.snowflake_database_name
  schema   = module.achs_prod_landing_schema.snowflake_schema_name
  name     = "DIAGNOSES_LND"
  comment  = "Landing table for diagnoses data"

  column {
    name = "RAW_DATA"
    type = "variant"
  }

  column {
    name     = "SOURCE_FILE"
    type     = "text"
    nullable = false
  }

  column {
    name     = "FILE_ROW_NUMBER"
    type     = "bigint"
    nullable = false
  }

  column {
    name     = "LOADED_AT_TIMESTAMP"
    type     = "timestamp_ntz"
    nullable = false
  }
}

resource "snowflake_table" "encounters_lnd_table" {
  database = module.achs_production_database.snowflake_database_name
  schema   = module.achs_prod_landing_schema.snowflake_schema_name
  name     = "ENCOUNTERS_LND"
  comment  = "Landing table for encounters data"

  column {
    name = "RAW_DATA"
    type = "variant"
  }

  column {
    name     = "SOURCE_FILE"
    type     = "text"
    nullable = false
  }

  column {
    name     = "FILE_ROW_NUMBER"
    type     = "bigint"
    nullable = false
  }

  column {
    name     = "LOADED_AT_TIMESTAMP"
    type     = "timestamp_ntz"
    nullable = false
  }
}

resource "snowflake_table" "patients_lnd_table" {
  database = module.achs_production_database.snowflake_database_name
  schema   = module.achs_prod_landing_schema.snowflake_schema_name
  name     = "PATIENTS_LND"
  comment  = "Landing table for patient data"

  column {
    name = "RAW_DATA"
    type = "variant"
  }

  column {
    name     = "SOURCE_FILE"
    type     = "text"
    nullable = false
  }

  column {
    name     = "FILE_ROW_NUMBER"
    type     = "bigint"
    nullable = false
  }

  column {
    name     = "LOADED_AT_TIMESTAMP"
    type     = "timestamp_ntz"
    nullable = false
  }
}

resource "snowflake_table" "providers_lnd_table" {
  database = module.achs_production_database.snowflake_database_name
  schema   = module.achs_prod_landing_schema.snowflake_schema_name
  name     = "PROVIDERS_LND"
  comment  = "Landing table for providers data"

  column {
    name = "RAW_DATA"
    type = "variant"
  }

  column {
    name     = "SOURCE_FILE"
    type     = "text"
    nullable = false
  }

  column {
    name     = "FILE_ROW_NUMBER"
    type     = "bigint"
    nullable = false
  }

  column {
    name     = "LOADED_AT_TIMESTAMP"
    type     = "timestamp_ntz"
    nullable = false
  }
}
