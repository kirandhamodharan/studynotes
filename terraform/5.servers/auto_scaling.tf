resource "aws_autoscaling_group" "ctb-asg" {
  name             = "ctb-asg"
  min_size         = 1
  max_size         = 2
  desired_capacity = 1
  vpc_zone_identifier = [data.aws_subnet.ctb_subnet_1.id, data.aws_subnet.ctb_subnet_2.id,
    data.aws_subnet.ctb_subnet_3.id, data.aws_subnet.ctb_subnet_4.id,
    data.aws_subnet.ctb_subnet_6.id
  ]

  launch_template {
    id      = aws_launch_template.ctb_launch_template.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.ctb-blog-target-group.arn,
    aws_lb_target_group.ctb-vpctools-target-group.arn
  ]
  health_check_type         = "ELB"
  wait_for_capacity_timeout = "0"
}