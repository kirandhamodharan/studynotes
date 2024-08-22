#!/bin/bash
# Wait to ensure network is set
for i in {1..24}; 
do
    curl https://www.google.com &> /dev/null && break;
    sleep 5
done

yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd mariadb-server

# Mount EFS
yum install -y amazon-efs-utils
mkdir /cloudtechbits
EFS_ID=fs-33aba787
mount -t efs -o tls $EFS_ID:/ /cloudtechbits

# Update Apache config files and start server
cp /cloudtechbits/serverconfig.conf /etc/httpd/conf/cloudtechbits.conf
sed -i 's/Listen *80/#Listen 80/g' /etc/httpd/conf/httpd.conf
echo "Include conf/cloudtechbits.conf" >> /etc/httpd/conf/httpd.conf
systemctl start httpd
systemctl enable httpd