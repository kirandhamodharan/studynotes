terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.24.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_subnet" "ctb_subnet_1" {
  tags = {
    Name = "ctb_subnet_1"
  }
}
data "aws_subnet" "ctb_subnet_2" {
  tags = {
    Name = "ctb_subnet_2"
  }
}
data "aws_subnet" "ctb_subnet_3" {
  tags = {
    Name = "ctb_subnet_3"
  }
}
data "aws_subnet" "ctb_subnet_4" {
  tags = {
    Name = "ctb_subnet_4"
  }
}
data "aws_subnet" "ctb_subnet_5" {
  tags = {
    Name = "ctb_subnet_5"
  }
}
data "aws_subnet" "ctb_subnet_6" {
  tags = {
    Name = "ctb_subnet_6"
  }
}

data "aws_security_group" "ctb_web_server_identifier" {
  name = "ctb_web_server_identifier_sg"
}

data "aws_vpc" "cloudtechbitsvpc" {
  tags = {
    Name = "Cloud Tech Bits"
  }
}