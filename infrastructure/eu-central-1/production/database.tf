module "achs_landing_zone_database" {
  source        = "../../modules/database"
  database_name = "ACHS_LND_PROD"
  comment       = "Landing zone production database for Angel City Health System's Data"
}

module "achs_staging_zone_database" {
  source        = "../../modules/database"
  database_name = "ACHS_STG_PROD"
  comment       = "Staging zone production database for Angel City Health System's Data"
}

module "achs_mart_zone_database" {
  source        = "../../modules/database"
  database_name = "ACHS_MRT_PROD"
  comment       = "Mart zone production database for Angel City Health System's Data"
}
