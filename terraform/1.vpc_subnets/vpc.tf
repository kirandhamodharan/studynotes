/*****************************
1. Create VPC with CIDR "10.0.0.0/16" and add an internet gateway
*****************************/

resource "aws_vpc" "cloudtechbitsvpc" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames = true

  tags = {
    Name = "Cloud Tech Bits"
  }
}
/****** ADD an internet gateway *******/
resource "aws_internet_gateway" "cloudtechbitsvpc_igw" {
  vpc_id = aws_vpc.cloudtechbitsvpc.id
}
