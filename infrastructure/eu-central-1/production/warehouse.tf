resource "snowflake_warehouse" "achs_warehouse" {
  name                      = "ACHS_WAREHOUSE"
  warehouse_type            = "STANDARD"
  warehouse_size            = "X-SMALL"
  generation                = "2"
  initially_suspended       = true
  auto_suspend              = 60
  auto_resume               = true
  enable_query_acceleration = true
  comment                   = "Warehouse for ACHS"
}
