#!/bin/bash

APPENV=$1

echo -e "\n--- Provisioning LinuxBuddy development machine. ---\n"

cd ~

echo -e "\n--- Installing Vim ---\n"
sudo yum install vim -y

