output "snowflake_fully_qualified_database_name" {
  value       = snowflake_database.database.fully_qualified_name
  description = "The fullly quaified name (db + schema) of the Snowflake database created."
}


output "snowflake_database_name" {
  value       = snowflake_database.database.id
  description = "The name of the Snowflake database created."
}
