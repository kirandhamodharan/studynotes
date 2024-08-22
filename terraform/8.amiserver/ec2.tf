resource "aws_instance" "ctbamisetupserver" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.ctb_subnet_1.id
  associate_public_ip_address = true
  key_name                    = "cloudtechbits_key"
  vpc_security_group_ids      = [data.aws_security_group.access_for_kiran_sg.id, data.aws_security_group.ctb_web_server_identifier_sg.id]
  user_data                   = replace(file("${path.module}/amisetup.sh"), "***EFS_ID***", data.aws_efs_file_system.ctb_efs.id)

  tags = {
    Name = "Cloud Tech Bit AMI Set up server"
  }
}