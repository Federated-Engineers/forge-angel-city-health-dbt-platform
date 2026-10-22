resource "snowflake_account_role" "data_ingestion" {
  name    = "DATA_INGESTION_ROLE"
  comment = "Role used for data ingestion into Snowflake."
}

resource "snowflake_account_role" "data_transformation" {
  name    = "DATA_TRANSFORMATION_ROLE"
  comment = "Role used for data transformation in Snowflake."
}
