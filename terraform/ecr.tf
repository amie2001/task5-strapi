# ECR Repository Creation
resource "aws_ecr_repository" "strapi_app" {
  name = var.ecr_repo_name

  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "${var.project_name}-ecr"
  }
}

# Docker Build and Push using `null_resource`
resource "null_resource" "docker_build_push" {
  provisioner "local-exec" {
    command = <<EOT
      docker build -t ${aws_ecr_repository.strapi_app.repository_url}:latest /home/ubuntu/strapi-application
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.strapi_app.repository_url}
      docker push ${aws_ecr_repository.strapi_app.repository_url}:latest
    EOT
  }

  depends_on = [
    aws_ecr_repository.strapi_app
  ]
}
