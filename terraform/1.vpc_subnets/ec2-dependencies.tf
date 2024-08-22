
/*****************************
Set the following dependencies needed to create an EC2
1. SSH key pair
2. Security Group to SSH into the EC2 from my pc
*****************************/

/***** SSH Key *****/
resource "aws_key_pair" "cloudtechbits_key" {
  key_name   = "cloudtechbits_key"
  public_key = var.ec2_ssh_key
}