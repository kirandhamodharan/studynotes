resource "aws_security_group" "ctb_db_sg" {
  name        = "ctb_db_sg"
  description = "Security Group for DB"
  vpc_id      = data.aws_vpc.cloudtechbitsvpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [data.aws_security_group.ctb_web_server_identifier.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ctb_db_sg"
  }
}