#!/bin/bash
# Amorçage instance (< 10 lignes) + lecture du secret Parameter Store
yum update -y && yum install -y httpd aws-cli
SECRET=$(aws ssm get-parameter --name "/novasphere/dev/db_password" --with-decryption --query "Parameter.Value" --output text --region us-east-1)
systemctl start httpd && systemctl enable httpd
echo "<h1>NovaSphere - DEV</h1><p>Secret lu : $SECRET</p>" > /var/www/html/index.html