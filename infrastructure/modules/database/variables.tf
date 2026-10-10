variable "database_name" {
  description = "The name of the Snowflake database to create."
  type        = string
  nullable    = false
}

variable "comment" {
  description = "An optional comment for the Snowflake database."
  type        = string
  default     = "Created by Terraform"
  nullable    = true
}
