# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg]

  tags = {
    Name        = "${var.env}-alb"
    Environment = var.env
    Project     = "online-bookstore"
  }
}

# Target Group for EC2 Instances
resource "aws_lb_target_group" "app_tg" {
  name        = "${var.env}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name        = "${var.env}-tg"
    Environment = var.env
    Project     = "online-bookstore"
  }
}

# Listener to Forward Traffic to Target Group
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

