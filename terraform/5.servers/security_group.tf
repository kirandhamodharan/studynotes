resource "aws_security_group" "ctb_web_server_sg" {
  name        = "ctb_web_server_sg"
  description = "Security Group for the servers"
  vpc_id      = data.aws_vpc.cloudtechbitsvpc.id

  ingress {
    from_port = 1980
    to_port   = 1981
    protocol  = "tcp"

    cidr_blocks = [data.aws_vpc.cloudtechbitsvpc.cidr_block]
    security_groups = [aws_security_group.ctb_alb_sg.id]
  }
  tags = {
    Name = "ctb_web_server_sg"
  }
}

resource "aws_security_group" "ctb_alb_sg" {
  name        = "ctb_alb_sg"
  description = "Security Group for the Load Balancer"
  vpc_id      = data.aws_vpc.cloudtechbitsvpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ctb_alb_sg"
  }
}