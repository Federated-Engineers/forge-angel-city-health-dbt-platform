terraform {
  backend "s3" {
    bucket       = "federated-production-forge-data-engineers-achs-tfstate-bucket" # Bucket should have versioning enabled
    key          = "production/terraform.tfstate"
    use_lockfile = true
    region       = "eu-central-1"
  }
}
