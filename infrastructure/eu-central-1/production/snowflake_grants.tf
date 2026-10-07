# Grants Usage Priviledge on the ACHS_PROD_DB to Data Ingestion and Data Transformation Roles
resource "snowflake_grant_privileges_to_account_role" "database_usage" {
  account_role_name = each.key
  privileges        = ["USAGE"]
  for_each = toset([
    snowflake_account_role.data_ingestion.name,
    snowflake_account_role.data_transformation.name
  ])

  on_account_object {
    object_type = "DATABASE"
    object_name = module.achs_production_database.snowflake_fully_qualified_database_name
  }
}

# Grants Usage Priviledge on the ACHS Warehouse to Data Ingestion and Data Transformation Roles
resource "snowflake_grant_privileges_to_account_role" "warehouse_usage" {
  account_role_name = each.key
  privileges        = ["USAGE"]
  for_each = toset([
    snowflake_account_role.data_ingestion.name,
    snowflake_account_role.data_transformation.name
  ])

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.achs_warehouse.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "schema_usage" {
  account_role_name = each.key
  privileges        = ["USAGE"]
  for_each = toset([
    snowflake_account_role.data_ingestion.name,
    snowflake_account_role.data_transformation.name
  ])

  on_schema {
    schema_name = module.achs_prod_landing_schema.snowflake_fully_qualified_schema_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "stage_read" {
  account_role_name = snowflake_account_role.data_ingestion.name
  privileges        = ["READ"]
  on_schema_object {
    object_type = "STAGE"
    object_name = snowflake_stage_external_s3.achs_landing_data_stage.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "storage_integration_usage" {
  account_role_name = snowflake_account_role.data_ingestion.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "INTEGRATION"
    object_name = snowflake_storage_integration_aws.achs_source_data_integration.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "file_format_usage" {
  account_role_name = snowflake_account_role.data_ingestion.name
  privileges        = ["USAGE"]
  on_schema_object {
    object_type = "FILE FORMAT"
    object_name = snowflake_file_format_json.achs_json_file_format.fully_qualified_name
  }
}

locals {
  landing_tables = tomap({
    claims     = snowflake_table.claims_lnd_table.fully_qualified_name,
    encounters = snowflake_table.encounters_lnd_table.fully_qualified_name,
    providers  = snowflake_table.providers_lnd_table.fully_qualified_name,
    patients   = snowflake_table.patients_lnd_table.fully_qualified_name,
    diagnoses  = snowflake_table.diagnoses_lnd_table.fully_qualified_name
  })
}

resource "snowflake_grant_privileges_to_account_role" "lnd_select_insert" {
  account_role_name = snowflake_account_role.data_ingestion.name
  privileges        = ["SELECT", "INSERT"]
  for_each          = local.landing_tables
  on_schema_object {
    object_type = "TABLE"
    object_name = each.value
  }
}

# Grant Transformation Role Privileges

# Grant Roles to Users
resource "snowflake_grant_account_role" "grant_role_to_user" {
  role_name = snowflake_account_role.data_ingestion.name
  user_name = snowflake_user.airflow.name
}

resource "snowflake_grant_account_role" "grant_data_transform_role_to_dbt_user" {
  role_name = snowflake_account_role.data_transformation.name
  user_name = snowflake_user.dbt.name
}
