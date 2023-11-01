# provision ALB

resource "aws_lb" "robot_alb" {
  name               = var.ALB_NAME
  internal           = var.INTERNAL  // if true means private load balancer and false means public load balancer
  load_balancer_type = "application"
  security_groups    = var.INTERNAL ? aws_security_group.alb_private.*.id : aws_security_group.alb_public.*.id
  subnets            = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS : data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS

  # enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = var.ALB_NAME
  }
}