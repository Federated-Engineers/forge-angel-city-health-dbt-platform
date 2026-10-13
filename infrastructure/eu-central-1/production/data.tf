data "aws_caller_identity" "current" {}

data "aws_iam_openid_connect_provider" "github_user_id_provider" {
  url = "https://token.actions.githubusercontent.com"
}

# To Do: Rename bucket name of data source block once migrated to Atlantis
data "aws_s3_bucket" "achs_data_source_bucket" {
  bucket = "angel-city-health-data"
  region = "eu-central-1"
}

data "aws_ssm_parameter" "snowflake_airflow_user" {
  name            = aws_ssm_parameter.snowflake_airflow_user_password.name
  with_decryption = true
}

data "aws_ssm_parameter" "snowflake_dbt_user" {
  name            = aws_ssm_parameter.snowflake_dbt_user_password.name
  with_decryption = true
}
