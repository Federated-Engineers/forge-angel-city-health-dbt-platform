variable "database_name" {
  description = "The name of the Snowflake database to create schema in."
  type        = string
  nullable    = false
}

variable "schema_name" {
  description = "The name of the Snowflake Schema to create."
  type        = string
  nullable    = false
}

variable "comment" {
  description = "An optional comment for the Snowflake schema."
  type        = string
  default     = "Created by Terraform"
  nullable    = true
}
