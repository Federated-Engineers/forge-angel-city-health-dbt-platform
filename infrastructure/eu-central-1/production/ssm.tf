resource "aws_ssm_parameter" "snowflake_org_name" {
  name        = "/achs/dbt/snowflake_org_name"
  value       = "CUUXYNZ"
  type        = "String"
  description = "Snowflake Organization Name"
}

resource "aws_ssm_parameter" "snowflake_account_name" {
  name        = "/achs/dbt/snowflake_account_name"
  value       = "MP95162"
  type        = "String"
  description = "Snowflake Account Name"
}

resource "aws_ssm_parameter" "snowflake_user" {
  name        = "/achs/dbt/snowflake_user"
  value       = "TERRAFORM_SVC"
  type        = "String"
  description = "Snowflake User name"
}

resource "aws_ssm_parameter" "snowflake_role" {
  name        = "/achs/dbt/snowflake_role"
  value       = "INFRA_SETUP"
  type        = "String"
  description = "Snowflake Role name"
}

resource "aws_ssm_parameter" "snowflake_private_key" {
  name             = "/achs/dbt/snowflake_private_key"
  value_wo         = file("~/.ssh/achs_snowflake_key")
  value_wo_version = 1
  type             = "SecureString"
  description      = "Snowflake Private Key"
}
