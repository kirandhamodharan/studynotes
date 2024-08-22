resource "aws_lb" "ctb-alb" {
  name               = "ctb-alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [data.aws_subnet.ctb_subnet_1.id, data.aws_subnet.ctb_subnet_2.id,
  data.aws_subnet.ctb_subnet_3.id, data.aws_subnet.ctb_subnet_4.id, data.aws_subnet.ctb_subnet_6.id]
  security_groups = [aws_security_group.ctb_alb_sg.id]
}


resource "aws_lb_listener" "ctb-alb-listener" {
  load_balancer_arn = aws_lb.ctb-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.ctb_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ctb-blog-target-group.arn
  }
}

resource "aws_lb_listener_rule" "ctb_vpctools_listner_rule" {
  listener_arn = aws_lb_listener.ctb-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ctb-vpctools-target-group.arn
  }

  condition {
    host_header {
      values = ["vpctools.cloudtechbits.com"]
    }
  }
}

/*
resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_lb_listener.front_end.arn
  certificate_arn = data.aws_acm_certificate.ctb_cert.arm
}
*/

