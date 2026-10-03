resource "snowflake_account_role" "data_ingestion" {
  name    = "DATA_INGESTION_ROLE"
  comment = "Role used for data ingestion into Snowflake."
}
