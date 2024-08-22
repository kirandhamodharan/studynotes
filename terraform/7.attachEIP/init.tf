terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.24.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}