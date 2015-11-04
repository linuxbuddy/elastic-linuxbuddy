#!/bin/bash

APPENV=$1

echo -e "\n--- Provisioning LinuxBuddy development machine. ---\n"

cd ~

echo -e "\n--- Installing Vim ---\n"
sudo yum install vim -y

echo -e "\n--- Installing Git ---\n"
sudo yum install git -y

echo -e "\n--- Installing Apache ---\n"
sudo yum install httpd -y

echo -e "\n--- Configuring Autostart Apache ---\n"
sudo chkconfig httpd on

echo -e "\n--- Setting link /vagrant/public /var/www ---\n"
if ! [ -L /var/www ]; then
  sudo rm -rf /var/www
  sudo ln -fs /vagrant/ /var/www
fi

echo -e "\n--- Adding httpd.conf ---\n"
sudo cp /vagrant/provisioning/files/etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf

echo -e "\n--- Adding 00-linuxbuddy.dev.conf ---\n"
sudo cp /vagrant/provisioning/files/etc/httpd/conf.d/00-linuxbuddy.dev.conf /etc/httpd/conf.d/00-linuxbuddy.dev.conf

echo -e "\n--- Installing Webtatic Repo ---\n"
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

echo -e "\n--- Installing PHP 5.6 ---\n"
sudo yum install php56w php56w-opcache php56w-mbstring php56w-xml php56w-intl -y

echo -e "\n--- Installing Composer ---\n"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo -e "\n--- Installing Java 1.7.0 ---\n"
sudo yum install java-1.7.0-openjdk* -y 

echo -e "\n--- Updating Yum Repository for Elasticsearch ---\n"
cat > /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch-1.7]
name=Elasticsearch repository for 1.7.x packages
baseurl=http://packages.elastic.co/elasticsearch/1.7/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
EOF

echo -e "\n--- Installing Elasticsearch ---\n"
sudo yum install elasticsearch --enablerepo elasticsearch-1.7 -y

echo -e "\n--- Configuring Autostart Elasticsearch ---\n"
sudo chkconfig --add elasticsearch

echo -e "\n--- Installing PHP application dependecies via Composer ---\n"
cd /vagrant/
sudo php /usr/local/bin/composer install

echo -e "\n--- Temp 777 permissions /vagrant/storage/logs/ ---\n"
sudo chmod -R 777 /vagrant/storage/logs/

echo -e "\n--- Starting Apache ---\n"
sudo service httpd start

echo -e "\n--- Starting Elasticsearch ---\n"
sudo service elasticsearch start



