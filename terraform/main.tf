resource "aws_instance" "strapi_task4" {
  ami                    = "ami-0e35ddab05955cf57"  # Ubuntu AMI (Mumbai region)
  instance_type          = "t2.medium"
  key_name               = "strapi-using-docker"     # Your EC2 key pair name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.strapi_sg_task4.name]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io unzip
    systemctl start docker
    usermod -aG docker ubuntu

    # Install AWS CLI v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    # Login to Amazon ECR
    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 864899875002.dkr.ecr.ap-south-1.amazonaws.com

    # Pull the Strapi Docker image from ECR using the provided tag
    docker pull ${var.ecr_repository}:${var.image_tag}

    # Run the Strapi container
    docker run -d -p 80:1337 \
      -e APP_KEYS="toBeModified1,toBeModified2" \
      -e API_TOKEN_SALT="tobemodified" \
      -e ADMIN_JWT_SECRET="tobemodified" \
      -e TRANSFER_TOKEN_SALT="tobemodified" \
      -e JWT_SECRET="tobemodified" \
      ${var.ecr_repository}:${var.image_tag}
  EOF

  tags = {
    Name = "StrapiApp"
  }
}
