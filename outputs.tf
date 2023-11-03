output "ALB_ARN" {
    
    value = aws_lb.robot_alb.arn

}

output "LISTENER_ARN" {
    
    value = aws_lb_listener.private.*.arn // * is coming to picutr becoz we are using a count , i am only taking the 1st value , if it is 0 thereis no point and if it is 1 then i need to take and capture it

}


output "ALB_ADDRESS" {
  value = aws_lb.robot_alb.dns_name
}