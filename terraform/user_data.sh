#!/bin/bash
# Update and install Docker and AWS CLI
yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Login to Amazon ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 864899875002.dkr.ecr.ap-south-1.amazonaws.com

# Pull the Strapi Docker image from ECR using the provided tag
docker pull ${var.ecr_repository}:${var.image_tag}

# Run the Strapi container with environment variables
docker run -d -p 80:1337 \
  -e APP_KEYS="toBeModified1,toBeModified2" \
  -e API_TOKEN_SALT="tobemodified" \
  -e ADMIN_JWT_SECRET="tobemodified" \
  -e TRANSFER_TOKEN_SALT="tobemodified" \
  -e JWT_SECRET="tobemodified" \
  ${var.ecr_repository}:${var.image_tag}
