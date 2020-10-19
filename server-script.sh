#!/bin/bash
sudo yum update
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Would you possibly like a cup of tea?</h1>" | sudo tee /var/www/html/index.html
