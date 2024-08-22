#!/bin/bash
yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd mariadb-server php-gd
yum install -y amazon-efs-utils
mkdir /cloudtechbits

sed -i 's/Listen *80/#Listen 80/g' /etc/httpd/conf/httpd.conf
echo "Include /cloudtechbits/blogs/conf/cloudtechbits.conf" >> /etc/httpd/conf/httpd.conf

# Install Node 14.16.0 #Latest as of 2/25
curl -o node-v14.16.0-linux-x64.tar.xz https://nodejs.org/dist/v14.16.0/node-v14.16.0-linux-x64.tar.xz
tar -xf node-v14.16.0-linux-x64.tar.xz
rm node-v14.16.0-linux-x64.tar.xz
# /node-v14.16.0-linux-x64/bin/node

mount -t efs -o tls ***EFS_ID***:/ /cloudtechbits
mkdir /vpctools
cp -r /cloudtechbits/vpctools/server /vpctools/

ln -s /node-v14.16.0-linux-x64/bin/node /usr/bin/node
/node-v14.16.0-linux-x64/bin/npm --prefix /vpctools/server install

umount  /cloudtechbits


export VPCTOOLS_SERVICE="/etc/systemd/system/vpctoolsserver.service"
echo "[Unit]" >> $VPCTOOLS_SERVICE
echo "Description=Node service for vpctools App" >> $VPCTOOLS_SERVICE
echo "After=network.target" >> $VPCTOOLS_SERVICE
echo "StartLimitIntervalSec=0" >> $VPCTOOLS_SERVICE
echo "" >> $VPCTOOLS_SERVICE
echo "[Service]" >> $VPCTOOLS_SERVICE
echo "Type=simple" >> $VPCTOOLS_SERVICE
echo "Restart=always" >> $VPCTOOLS_SERVICE
echo "RestartSec=1" >> $VPCTOOLS_SERVICE
echo "User=root" >> $VPCTOOLS_SERVICE
echo "ExecStart=/node-v14.16.0-linux-x64/bin/node /vpctools/server/index.js" >> $VPCTOOLS_SERVICE
echo "" >> $VPCTOOLS_SERVICE
echo "" >> $VPCTOOLS_SERVICE
echo "[Install]" >> $VPCTOOLS_SERVICE
echo "WantedBy=multi-user.target" >> $VPCTOOLS_SERVICE

usermod -a -G apache ec2-user
