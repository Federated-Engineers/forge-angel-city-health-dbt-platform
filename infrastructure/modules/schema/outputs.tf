output "snowflake_fully_qualified_schema_name" {
  value       = snowflake_schema.schema.fully_qualified_name
  description = "The name of the Snowflake schema created."
}

output "snowflake_schema_name" {
  value       = snowflake_schema.schema.name
  description = "The name of the Snowflake schema created."
}
