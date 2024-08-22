resource "aws_security_group" "ctb_web_server_identifier_sg" {
  name        = "ctb_web_server_identifier_sg"
  description = "Security Group with no inbound rules"
  vpc_id      = aws_vpc.cloudtechbitsvpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ctb_web_server_identifier_sg"
  }
}

resource "aws_security_group" "access_for_kiran" {
  name        = "access_for_kiran_sg"
  description = "Security Group for all access from current IP for Dev / Test / Debugging"
  vpc_id      = aws_vpc.cloudtechbitsvpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [format("%s%s", chomp(data.http.myip.body), "/32")]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh_for_kiran_sg"
  }
}