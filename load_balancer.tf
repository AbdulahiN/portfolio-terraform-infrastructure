#Load Balancer

resource "aws_lb" "portfolio_lb" {
  name               = "portfolio-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.portfolio_subnet1.id, aws_subnet.portfolio_subnet2.id]

  security_groups = [aws_security_group.portfolio_security_group.id]

  tags = {
    Name = "portfolio-lb"
  }
}

resource "aws_lb_target_group" "portfolio_target_group" {
  name     = "portfolio-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.portfolio_vpc.id

  health_check {
    path = "/"
  }

  tags = {
    Name = "portfolio-target-group"
  }
}

resource "aws_lb_listener" "portfolio_listener" {
  load_balancer_arn = aws_lb.portfolio_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.portfolio_target_group.arn
  }
}
