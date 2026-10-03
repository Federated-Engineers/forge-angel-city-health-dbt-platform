module "achs_prod_landing_schema" {
  source        = "../../modules/schema"
  database_name = module.achs_production_database.snowflake_database_name
  schema_name   = "LANDING_SCHEMA"
  comment       = "Landing zone for Angel City Health System's Data"
}
