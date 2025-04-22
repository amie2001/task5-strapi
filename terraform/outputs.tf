# Output the EC2 public IP address
output "ec2_public_ip" {
  description = "The public IP address of the Strapi EC2 instance"
  value       = aws_instance.strapi_task4.public_ip
}

# Output the ECR repository URL
output "ecr_repository_url" {
  description = "The URL of the ECR repository where the Strapi Docker image is stored"
  value       = var.ecr_repository
}

# Output the EC2 instance ID
output "ec2_instance_id" {
  description = "The EC2 instance ID for the Strapi app"
  value       = aws_instance.strapi_task4.id
}

# Output the security group ID
output "strapi_sg_id" {
  description = "The ID of the security group for the Strapi EC2 instance"
  value       = aws_security_group.strapi_sg_task4.id
}
