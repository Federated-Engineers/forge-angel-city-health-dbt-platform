terraform {
  required_version = ">= 1.10.0"
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "2.16.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.37.0"
    }
  }
  backend "s3" {
    bucket       = "terraform-state-files-409021554022"
    key          = "labs/achs_terraform.tfstate"
    use_lockfile = true
    region       = "us-west-2"
  }
}

provider "snowflake" {
  organization_name = var.snowflake_org_name
  account_name      = var.snowflake_account_name
  user              = var.snowflake_user
  password          = var.snowflake_password
  authenticator     = "SNOWFLAKE"
  role              = "SYSADMIN"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Terraform = "yes"
      Team      = "forge"
    }
  }
}
