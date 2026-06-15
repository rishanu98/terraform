resource "aws_lb_target_group" "app_tg" {
  name     = "app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
  tags = {
    Name = "AppTargetGroup"
  }
}

resource "aws_lb_target_group_attachment" "web-tg-attachment" {

  count = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
} 

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_security_group]

  enable_deletion_protection = false

  tags = {
    Name = "AppLoadBalancer"
  }
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.app_tg.arn
      }
    }
  }
}

