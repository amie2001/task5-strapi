# AWS Region
variable "aws_region" {
  description = "The AWS region for deploying resources"
  type        = string
  default     = "ap-south-1"  # Mumbai region
}

# Docker image tag to be used for the EC2 instance
variable "image_tag" {
  description = "The Docker image tag to deploy"
  type        = string
}

# ECR repository URL for the Strapi image
variable "ecr_repository" {
  description = "The ECR repository URL for the Strapi Docker image"
  type        = string
  default     = "864899875002.dkr.ecr.ap-south-1.amazonaws.com/strapi-app-task4"
}

# EC2 Instance type
variable "instance_type" {
  description = "The EC2 instance type for the Strapi application"
  type        = string
  default     = "t2.medium"
}

# AMI ID for the EC2 instance, should be updated based on the region
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0e35ddab05955cf57"  # Amazon Linux 2 AMI for Mumbai region
}

# Key pair name for EC2 SSH access
variable "key_name" {
  description = "The EC2 key pair name for SSH access"
  type        = string
  default     = "strapi-using-docker"  # Replace with your key pair name
}
