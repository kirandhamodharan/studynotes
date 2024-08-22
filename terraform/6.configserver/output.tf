output "public_id" {
  value = "ssh -i ~/.ssh/cloudtechbits_rsa ec2-user@${aws_instance.configserver.public_ip}"
}