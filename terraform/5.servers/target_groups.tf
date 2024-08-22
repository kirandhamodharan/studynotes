resource "aws_lb_target_group" "ctb-blog-target-group" {
  name     = "ctb-blog-target-group"
  port     = 1980
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.cloudtechbitsvpc.id

  health_check {
    port                = 1980 //"traffic-port"
    path                = "/ping.html"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    interval            = 30
  }
}

resource "aws_lb_target_group" "ctb-vpctools-target-group" {
  name     = "ctb-vpctools-target-group"
  port     = 1981
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.cloudtechbitsvpc.id

  health_check {
    port                = 1981 //"traffic-port"
    path                = "/index.html"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    interval            = 30
  }
}