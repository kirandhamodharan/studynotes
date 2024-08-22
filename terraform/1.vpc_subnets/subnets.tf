/*****************************
1. Create a public subnet with CIDR 10.0.0.0/23
507 IPs (THe VPC is split into 128 subnets)
*****************************/
resource "aws_subnet" "ctb_subnet_1" {
  vpc_id                          = aws_vpc.cloudtechbitsvpc.id
  cidr_block                      = "10.0.0.0/23"
  #ipv6_cidr_block                 = "2600:1f18:41dd:6f01::/64"
  //assign_ipv6_address_on_creation = true
  availability_zone               = format("%s%s", data.aws_region.current.name, "a")
  tags = {
    Name = "ctb_subnet_1"
  }
}

resource "aws_subnet" "ctb_subnet_2" {
  vpc_id                          = aws_vpc.cloudtechbitsvpc.id
  cidr_block                      = "10.0.2.0/23"
  #ipv6_cidr_block                 = "2600:1f18:41dd:6f01::/64"
  //assign_ipv6_address_on_creation = true
  availability_zone               = format("%s%s", data.aws_region.current.name, "b")
  tags = {
    Name = "ctb_subnet_2"
  }
}

resource "aws_subnet" "ctb_subnet_3" {
  vpc_id                          = aws_vpc.cloudtechbitsvpc.id
  cidr_block                      = "10.0.4.0/23"
  #ipv6_cidr_block                 = "2600:1f18:41dd:6f01::/64"
  //assign_ipv6_address_on_creation = true
  availability_zone               = format("%s%s", data.aws_region.current.name, "c")
  tags = {
    Name = "ctb_subnet_3"
  }
}

resource "aws_subnet" "ctb_subnet_4" {
  vpc_id                          = aws_vpc.cloudtechbitsvpc.id
  cidr_block                      = "10.0.6.0/23"
  #ipv6_cidr_block                 = "2600:1f18:41dd:6f01::/64"
  //assign_ipv6_address_on_creation = true
  availability_zone               = format("%s%s", data.aws_region.current.name, "d")
  tags = {
    Name = "ctb_subnet_4"
  }
}

resource "aws_subnet" "ctb_subnet_5" {
  vpc_id                          = aws_vpc.cloudtechbitsvpc.id
  cidr_block                      = "10.0.8.0/23"
  #ipv6_cidr_block                 = "2600:1f18:41dd:6f01::/64"
  //assign_ipv6_address_on_creation = true
  availability_zone               = format("%s%s", data.aws_region.current.name, "e")
  tags = {
    Name = "ctb_subnet_5"
  }
}

resource "aws_subnet" "ctb_subnet_6" {
  vpc_id                          = aws_vpc.cloudtechbitsvpc.id
  cidr_block                      = "10.0.10.0/23"
  #ipv6_cidr_block                 = "2600:1f18:41dd:6f01::/64"
  //assign_ipv6_address_on_creation = true
  availability_zone               = format("%s%s", data.aws_region.current.name, "f")
  tags = {
    Name = "ctb_subnet_6"
  }
}

resource "aws_route_table" "r_public" {
  vpc_id = aws_vpc.cloudtechbitsvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudtechbitsvpc_igw.id
  }
  tags = {
    Name = "CTB Default Route"
  }
}

resource "aws_route_table_association" "r_public_association_1" {
  subnet_id      = aws_subnet.ctb_subnet_1.id
  route_table_id = aws_route_table.r_public.id
}
resource "aws_route_table_association" "r_public_association_2" {
  subnet_id      = aws_subnet.ctb_subnet_2.id
  route_table_id = aws_route_table.r_public.id
}
resource "aws_route_table_association" "r_public_association_3" {
  subnet_id      = aws_subnet.ctb_subnet_3.id
  route_table_id = aws_route_table.r_public.id
}
resource "aws_route_table_association" "r_public_association_4" {
  subnet_id      = aws_subnet.ctb_subnet_4.id
  route_table_id = aws_route_table.r_public.id
}
resource "aws_route_table_association" "r_public_association_5" {
  subnet_id      = aws_subnet.ctb_subnet_5.id
  route_table_id = aws_route_table.r_public.id
}
resource "aws_route_table_association" "r_public_association_6" {
  subnet_id      = aws_subnet.ctb_subnet_6.id
  route_table_id = aws_route_table.r_public.id
}

resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.cloudtechbitsvpc.id
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
    icmp_code  = 0
    icmp_type  = 0
  }
  ingress {
    protocol        = "tcp"
    rule_no         = 101
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 65535
    icmp_code       = 0
    icmp_type       = 0
  }
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    to_port    = "0"
    icmp_code  = 0
    icmp_type  = 0
  }
  egress {
    protocol        = "-1"
    rule_no         = 101
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = "0"
    to_port         = "0"
    icmp_code       = 0
    icmp_type       = 0
  }

  subnet_ids = [aws_subnet.ctb_subnet_1.id, aws_subnet.ctb_subnet_2.id, aws_subnet.ctb_subnet_3.id,
  aws_subnet.ctb_subnet_4.id,aws_subnet.ctb_subnet_5.id,aws_subnet.ctb_subnet_6.id]

  tags = {
    Name = "CTB Default ACL"
  }
}