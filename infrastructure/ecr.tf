
resource "aws_ecr_repository" "dbt_repo" {
  name                 = "achs/dbt-core"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
