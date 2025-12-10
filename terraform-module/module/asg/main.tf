provider "aws" {
    region = var.region
}

#SG-asg
resource "aws_security_group" "asg_sg" {
  name= "${var.project}-asg-sg"
  description = "Allows http of instance"
  vpc_id = var.vpc_id

  ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
  }
}

#Launch template-instance1
resource "aws_launch_template" "template_1" {
  name_prefix = var.name
  image_id = var.ami_id
  instance_type = var.instance_type
  security_group_names = [aws_security_group.asg_sg.id]
}

#AutoScaling group frontend
resource "aws_autoscaling_group" "asg_fe" {
  name = "${var.project}-asg"
  availability_zones = var.az_1
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.template_1.id
    version = "$Latest"
  }
}

#launch Template-instance2
resource "aws_launch_template" "template_2" {
  name_prefix = var.name2
  image_id = var.ami_id
  instance_type =var.instance_type
}

#ASG backend
resource "aws_autoscaling_group" "asg_be" {
  availability_zones = var.az_2
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.template_2.id
    version = "$Latest"
  }
}

# ASG+ALB frontend attachment
resource "aws_autoscaling_attachment" "asg_to_alb_fe" {
  autoscaling_group_name = aws_autoscaling_group.asg_fe.id
  lb_target_group_arn    = module.alb.aws_lb_target_group.my_tg.arn
}
#ASG+ALB backend attachment
resource "aws_autoscaling_attachment" "asg_to_alb_be" {
  autoscaling_group_name = aws_autoscaling_group.asg_be.id
  lb_target_group_arn    = module.alb.aws_lb_target_group.my_tg.arn
}
