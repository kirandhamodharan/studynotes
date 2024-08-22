resource "aws_launch_template" "ctb_launch_template" {
  name                   = "cloudtechbits_server"
  description            = "Template for CTB web servers"
  image_id               = data.aws_ami.ctb_server.id
  instance_type          = "t3.micro"
  key_name               = "cloudtechbits_key"
  update_default_version = true
  vpc_security_group_ids = [data.aws_security_group.ctb_web_server_identifier_sg.id, aws_security_group.ctb_web_server_sg.id]
  user_data              = base64encode(replace(file("${path.module}/startup.sh"), "***EFS_ID***", data.aws_efs_file_system.ctb_efs.id))
}