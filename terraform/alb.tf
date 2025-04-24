# ALB Creation
resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "${var.project_name}-alb"
  }
}

# ALB Listener (HTTP)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }
}

# ALB Target Group for ECS Fargate Service
resource "aws_lb_target_group" "ecs_target_group" {
  name        = "${var.project_name}-target-group"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"  # <-- IMPORTANT for ECS Fargate with awsvpc

  health_check {
    path                = "/admin"
    protocol            = "HTTP"
    interval            = 60
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  tags = {
    Name = "${var.project_name}-target-group"
  }
}
