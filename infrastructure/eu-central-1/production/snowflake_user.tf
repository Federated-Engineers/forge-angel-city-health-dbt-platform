resource "snowflake_user" "airflow" {
  name                 = "AIRFLOW_DATA_LOAD_USER"
  password             = data.aws_ssm_parameter.snowflake_airflow_user.value
  default_role         = snowflake_account_role.data_ingestion.name
  must_change_password = false
  comment              = "Used by Airflow to run COPY INTO commands on Snowflake."
}
