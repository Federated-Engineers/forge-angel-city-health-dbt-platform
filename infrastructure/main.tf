resource "snowflake_database" "angel_city_lnd_db" {
  name         = "ACHS_LND_DB"
  is_transient = false
}

resource "snowflake_database" "angel_city_stg_db" {
  name         = "ACHS_STG_DB"
  is_transient = false
}

resource "snowflake_database" "angel_city_gold_db" {
  name         = "ACHS_GOLD_DB"
  is_transient = false
}

resource "snowflake_warehouse" "angel_city_warehouse" {
  name                      = "ANGEL_CITY_WH"
  warehouse_type            = "STANDARD"
  warehouse_size            = "XSMALL"
  max_cluster_count         = 1
  min_cluster_count         = 1
  auto_suspend              = 60
  auto_resume               = true
  enable_query_acceleration = false
  initially_suspended       = true
}
