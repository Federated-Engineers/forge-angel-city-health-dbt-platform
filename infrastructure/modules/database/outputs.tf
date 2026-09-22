output "snowflake_database_name" {
  value       = snowflake_database.database.fully_qualified_name
  description = "The name of the Snowflake database created."
}
