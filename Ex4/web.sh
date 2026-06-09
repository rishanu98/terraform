#!/bin/bash
set -e

sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

sudo apt-get update
sudo apt-get install -y -f
sudo apt-get install -y --fix-missing wget unzip apache2

sudo systemctl start apache2
sudo systemctl enable apache2

cd /tmp
wget -O website.zip https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip -o website.zip

sudo cp -r 2117_infinite_loop/* /var/www/html/

sudo systemctl restart apache2