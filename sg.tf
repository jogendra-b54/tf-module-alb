# Public Load Balancer Security Group
resource "aws_security_group" "alb_public" {
  count       = var.INTERNAL ? 0 : 1
  name        = "roboshop-${var.ENV}-public-alb-sg"
  description = "Allows Traffic From Internet"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     
  } 


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  tags = {
    Name = "roboshop-${var.ENV}-public-alb-sg"
  }
}

# Private Load Balancer Security Group

# Public Load Balancer Security Group
resource "aws_security_group" "alb_private" {
  count       =   var.INTERNAL ? 1 : 0
  name        = "roboshop-${var.ENV}-private-alb-sg"
  description = "Allows Traffic From Intranet Only"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

    ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]     
  } 

 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
 
  tags = {
    Name = "roboshop-${var.ENV}-private-alb-sg"
  }
}
