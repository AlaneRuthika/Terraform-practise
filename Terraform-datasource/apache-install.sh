#! /bin/bash
sudo apt update -y
sudo apt install apache-2 -y
sudo systemctl enable httpd
sudo tee /var/www/html/index.html