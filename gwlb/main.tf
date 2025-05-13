resource "aws_lb" "gwlb" {
  name               = "gateway-lb"
  load_balancer_type = "gateway"
  subnets            = [var.gwlb_subnet_id]  # Place in Security VPC
}

resource "aws_lb_target_group" "gwlb_tg" {
  name     = "gwlb-targets"
  port     = 6081
  protocol = "GENEVE"
  vpc_id   = var.vpc_ids[1] # Security VPC
  target_type = "instance"
}