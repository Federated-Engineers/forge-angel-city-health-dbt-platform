variable "snowflake_org_name" {
  type        = string
  description = "Snowflake Organization Name"
  sensitive   = true
  nullable    = false
}

variable "snowflake_account_name" {
  type        = string
  description = "Snowflake Account Name"
  sensitive   = true
  nullable    = false
}

variable "snowflake_user" {
  type        = string
  description = "Snowflake Authentication Username"
  sensitive   = true
  nullable    = false
}

variable "snowflake_password" {
  type        = string
  description = "Snowflake Authentication Password"
  sensitive   = true
  nullable    = false
}

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS & Snowflake Region"
  sensitive   = false
  nullable    = false
}
