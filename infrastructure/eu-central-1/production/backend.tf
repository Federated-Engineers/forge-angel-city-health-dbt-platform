# terraform {
#   backend "s3" {
#     bucket       = "federated-production-forge-data-engineers-achs-tfstate-bucket" # Bucket should have versioning enabled
#     key          = "production/terraform.tfstate"
#     use_lockfile = true
#     region       = "eu-central-1"
#   }
# }

terraform {
  backend "s3" {
    bucket       = "terraform-state-files-409021554022" # Bucket should have versioning enabled
    key          = "labs/achs/terraform.tfstate"
    use_lockfile = true
    region       = "us-west-2"
  }
}
