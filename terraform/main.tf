provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "strapi_sg_task4" {
  name        = "strapi-sg_task4"
  description = "Security group for Strapi EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (can be restricted for security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "strapi_task4" {
  ami                    = "ami-0e35ddab05955cf57"  
  instance_type          = "t2.medium"              
  key_name               = "strapi-using-docker"     
  associate_public_ip_address = true
  security_groups = [aws_security_group.strapi_sg_task4.name]

  user_data = file("terraform/user_data.sh")

  tags = {
    Name = "StrapiApp"
  }
}

