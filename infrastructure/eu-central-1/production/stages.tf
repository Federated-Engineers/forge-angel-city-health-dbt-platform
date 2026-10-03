resource "snowflake_storage_integration_aws" "achs_source_data_integration" {
  name                      = "ACHS_SOURCE_DATA_INTEGRATION"
  storage_provider          = "S3"
  storage_aws_role_arn      = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.snowflake_integration_path}SnowflakeStorageIntegrationRole"
  enabled                   = true
  storage_allowed_locations = ["s3://${data.aws_s3_bucket.achs_data_source_bucket.id}/achs_data/"]
  comment                   = "Generates AWS IAM User Session credentials from IAM Role and stores for 60 minutes max."
}

resource "snowflake_file_format_json" "achs_json_file_format" {
  name     = "ACHS_JSON_FILE_FORMAT"
  database = module.achs_production_database.snowflake_database_name
  schema   = module.achs_prod_landing_schema.snowflake_schema_name
  comment  = "File format for ACHS json data stored in S3 bucket."
}

resource "snowflake_stage_external_s3" "achs_landing_data_stage" {
  name                = "ACHS_LANDING_DATA_STAGE"
  database            = module.achs_production_database.snowflake_database_name
  schema              = module.achs_prod_landing_schema.snowflake_schema_name
  url                 = "s3://${data.aws_s3_bucket.achs_data_source_bucket.id}/achs_data/"
  storage_integration = snowflake_storage_integration_aws.achs_source_data_integration.name
  file_format {
    format_name = snowflake_file_format_json.achs_json_file_format.fully_qualified_name
  }
  comment = "Stage for ACHS claims data stored in S3 bucket."
}
