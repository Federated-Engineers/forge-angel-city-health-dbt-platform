module "achs_production_database" {
  source        = "../../modules/database"
  database_name = "ACHS_PROD_DB"
  comment       = "Production database for Angel City Health System's Data"
}
