variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"  # Mumbai Region
}

variable "container_port" {
  description = "Port that Strapi container listens on"
  default     = 1337  # Strapi default port
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  default     = "strapi-app-repo"
}

variable "project_name" {
  description = "Name of the project"
  default     = "strapi-app"
}             
