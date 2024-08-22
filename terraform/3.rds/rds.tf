resource "aws_db_subnet_group" "ctb_db_subnet_group" {
  name        = "cloudtechbits_db_subnets"
  description = "DB Security group for Cloud Tech Bits DB"
  subnet_ids = [data.aws_subnet.ctb_subnet_1.id,
    data.aws_subnet.ctb_subnet_2.id,
    data.aws_subnet.ctb_subnet_3.id,
    data.aws_subnet.ctb_subnet_4.id,
    data.aws_subnet.ctb_subnet_6.id ]

  tags = {
    Name = "cloudtechbits_db_subnets"
  }
}

resource "aws_rds_cluster" "ctb_db" {
  cluster_identifier     = "cloudtechbits-db"
  engine_mode            = "serverless"
  engine                 = "aurora"
  engine_version         = "5.6.10a"
  database_name          = "cloudtechbits"
  master_username        = "ctbbloguser"
  master_password        = "ctbbloguser"
  db_subnet_group_name   = aws_db_subnet_group.ctb_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ctb_db_sg.id]
  copy_tags_to_snapshot  = false
  skip_final_snapshot    = false

  enable_http_endpoint = true

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "RollbackCapacityChange"
  }
}