provider "aws" {
  region = var.aws_region
}

# This will call other Terraform files: vpc.tf, ecs.tf, etc.

~  
