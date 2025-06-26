#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
echo "<h1>Welcome to Online Bookstore via AutoScaling</h1>" > /var/www/html/index.html
sudo systemctl start apache2
sudo systemctl enable apache2

