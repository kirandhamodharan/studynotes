resource "aws_efs_file_system" "ctb_efs" {
  encrypted        = true
  performance_mode = "generalPurpose"

  tags = {
    "Name" = "ctb_efs"
  }

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

resource "aws_security_group" "ctb_efs_sg" {
  name        = "ctb_efs_sg"
  description = "Security Group for efs mount targets"
  vpc_id      = data.aws_vpc.cloudtechbitsvpc.id

  ingress {
    from_port       = 2049
    to_port         = 2049
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
    Name = "ctb_efs_sg"
  }
}

resource "aws_efs_mount_target" "ctb_mount_target_1" {
  file_system_id  = aws_efs_file_system.ctb_efs.id
  subnet_id       = data.aws_subnet.ctb_subnet_1.id
  security_groups = [aws_security_group.ctb_efs_sg.id]
}
resource "aws_efs_mount_target" "ctb_mount_target_2" {
  file_system_id  = aws_efs_file_system.ctb_efs.id
  subnet_id       = data.aws_subnet.ctb_subnet_2.id
  security_groups = [aws_security_group.ctb_efs_sg.id]
}
resource "aws_efs_mount_target" "ctb_mount_target_3" {
  file_system_id  = aws_efs_file_system.ctb_efs.id
  subnet_id       = data.aws_subnet.ctb_subnet_3.id
  security_groups = [aws_security_group.ctb_efs_sg.id]
}
resource "aws_efs_mount_target" "ctb_mount_target_4" {
  file_system_id  = aws_efs_file_system.ctb_efs.id
  subnet_id       = data.aws_subnet.ctb_subnet_4.id
  security_groups = [aws_security_group.ctb_efs_sg.id]
}
resource "aws_efs_mount_target" "ctb_mount_target_5" {
  file_system_id  = aws_efs_file_system.ctb_efs.id
  subnet_id       = data.aws_subnet.ctb_subnet_5.id
  security_groups = [aws_security_group.ctb_efs_sg.id]
}
resource "aws_efs_mount_target" "ctb_mount_target_6" {
  file_system_id  = aws_efs_file_system.ctb_efs.id
  subnet_id       = data.aws_subnet.ctb_subnet_6.id
  security_groups = [aws_security_group.ctb_efs_sg.id]
}
