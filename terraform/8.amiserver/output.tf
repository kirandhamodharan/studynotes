output "ssh_cmd" {
  value = "ssh -i ~/.ssh/cloudtechbits_rsa ec2-user@${aws_instance.ctbamisetupserver.public_ip}"
}