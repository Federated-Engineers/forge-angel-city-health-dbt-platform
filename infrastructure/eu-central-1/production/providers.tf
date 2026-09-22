terraform {
  required_version = ">= 1.15.0"
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = ">= 2.21.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.64.0"
    }
  }
}

provider "snowflake" {
  authenticator = "SNOWFLAKE_JWT"
}

provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      terraform = "yes"
      team      = "forge"
      project   = "angel-city-health-systems"
    }
  }
}
