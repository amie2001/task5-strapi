variable "region" {
  description = "AWS region"
  default     = "ap-south-1"  # Mumbai Region
}

variable "container_port" {
  description = "Port that Strapi container listens on"
  default     = 1337  # Strapi default port
}

variable "image_uri" {
  description = "URI of the Docker image in ECR"
  type        = string
}
