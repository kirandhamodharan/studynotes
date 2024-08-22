output "loadbalancer_dns" {
  value = aws_lb.ctb-alb.dns_name
}
output "action_needed" {
  value = "Update below DNS records if needed \n1. cloudtechbits.com\n2. www.cloudtechbits.com\n3. vpctools.cloudtechbits.com"
}