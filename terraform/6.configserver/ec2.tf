resource "aws_instance" "configserver" {
  ami                         = data.aws_ami.amazon_linux_2.id #"ami-03d8d7c40739ae65e"
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.ctb_subnet_1.id
  associate_public_ip_address = true
  key_name                    = "cloudtechbits_key"
  vpc_security_group_ids      = [data.aws_security_group.access_for_kiran_sg.id, data.aws_security_group.ctb_web_server_identifier_sg.id]
  #user_data                   = replace(file("${path.module}/startup.sh"), "***EFS_ID***", data.aws_efs_file_system.ctb_efs.id)

  tags = {
    Name = "Kiran's Config Server"
  }
}

/*
resource "aws_instance" "testserver" {
  ami                         = data.aws_ami.ctb_server.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.ctb_subnet_1.id
  associate_public_ip_address = true
  key_name                    = "cloudtechbits_key"
  vpc_security_group_ids      = [data.aws_security_group.access_for_kiran_sg.id, data.aws_security_group.ctb_web_server_identifier_sg.id]
  user_data                   = replace(file("${path.module}/startup.sh"), "***EFS_ID***", data.aws_efs_file_system.ctb_efs.id)

  tags = {
    Name = "Test Server"
  }
}
*/