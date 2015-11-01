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

