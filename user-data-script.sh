#!/bin/bash
dnf update -y
dnf install -y httpd php php-mysqlnd php-gd php-xml mariadb105
systemctl start httpd
systemctl enable httpd

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/wordpress_db/" /var/www/html/wp-config.php
sed -i "s/username_here/admin/" /var/www/html/wp-config.php
sed -i "s/password_here/WordPress123!/" /var/www/html/wp-config.php
sed -i "s/localhost/swe40006-wordpress-db.cne4wqysy391.ap-southeast-2.rds.amazonaws.com/" /var/www/html/wp-config.php

chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html/

systemctl restart httpd
