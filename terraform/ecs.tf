# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

# ECS Task Definition (Fargate)
resource "aws_ecs_task_definition" "strapi" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "strapi"
    image     = var.image_uri
    portMappings = [{
      containerPort = var.container_port
      protocol      = "tcp"
    }]
    environment = [
      { name = "APP_KEYS", value = "toBeModified1,toBeModified2" },
      { name = "API_TOKEN_SALT", value = "tobemodified" },
      { name = "ADMIN_JWT_SECRET", value = "tobemodified" },
      { name = "TRANSFER_TOKEN_SALT", value = "tobemodified" },
      { name = "JWT_SECRET", value = "tobemodified" },
      { name = "HOST", value = "0.0.0.0" },
      { name = "PORT", value = "1337" }
    ]
    logConfiguration = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = "/ecs/${var.project_name}"
      awslogs-region        = var.region
      awslogs-stream-prefix = "ecs"
    }
  }
}])

  execution_role_arn = "arn:aws:iam::864899875002:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::864899875002:role/ecsTaskExecutionRole"
}

# ECS Service (Fargate)
resource "aws_ecs_service" "strapi_service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = "strapi"
    container_port   = var.container_port
  }

  depends_on = [
    aws_lb_target_group.ecs_target_group
  ]
}
