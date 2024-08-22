#!/bin/bash
yum update -y
mount -t efs -o tls ***EFS_ID***:/ /cloudtechbits
systemctl start httpd
systemctl enable httpd
systemctl start vpctoolsserver
systemctl enable vpctoolsserver