resource "aws_ssm_parameter" "snowflake_org_name" {
  name        = "/achs/dbt/snowflake_org_name"
  value       = "YDEOKOC"
  type        = "String"
  description = "Snowflake Organization Name"
}

resource "aws_ssm_parameter" "snowflake_account_name" {
  name        = "/achs/dbt/snowflake_account_name"
  value       = "KP37309"
  type        = "String"
  description = "Snowflake Account Name"
}

resource "aws_ssm_parameter" "snowflake_dbt_user" {
  name        = "/achs/dbt/snowflake_user"
  value       = snowflake_user.dbt.name
  type        = "String"
  description = "Snowflake User name"
}

resource "aws_ssm_parameter" "snowflake_dbt_role" {
  name        = "/achs/dbt/snowflake_role"
  value       = snowflake_account_role.data_transformation.name
  type        = "String"
  description = "Snowflake Role name"
}

resource "aws_ssm_parameter" "snowflake_airflow_user_password" {
  name             = "/production/forge/achs/snowflake/airflow_user_password"
  type             = "SecureString"
  value_wo         = random_password.snowflake_airflow_password.result
  value_wo_version = 1
}
