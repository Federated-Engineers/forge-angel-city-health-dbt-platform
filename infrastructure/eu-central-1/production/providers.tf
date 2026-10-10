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
    random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }
  }
}

provider "snowflake" {
  authenticator            = "SNOWFLAKE"
  preview_features_enabled = ["snowflake_table_resource"]
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
