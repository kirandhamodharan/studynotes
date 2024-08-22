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

/***** AMI *****/
data "aws_ami" "amazon_linux_2" {
  filter {
    name   = "description"
    values = ["*Linux 2*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["*gp2*"]
  }
  filter {
    name   = "image-type"
    values = ["machine"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }

  owners      = ["137112412989"]
  most_recent = true
}

data "aws_subnet" "ctb_subnet_1" {
  tags = {
    Name = "ctb_subnet_1"
  }
}

data "aws_security_group" "access_for_kiran_sg" {
  name = "access_for_kiran_sg"
}

data "aws_security_group" "ctb_web_server_identifier_sg" {
  name = "ctb_web_server_identifier_sg"
}

data "aws_efs_file_system" "ctb_efs" {
  tags = {
    Name = "ctb_efs"
  }
}