output "elastic_ip" {
  value = "ssh -i ~/.ssh/cloudtechbits_rsa ec2-user@${aws_eip.ip.public_ip}"
}
