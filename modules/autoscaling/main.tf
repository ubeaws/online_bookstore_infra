resource "aws_launch_template" "bookstore_lt" {
  name_prefix   = "${var.env}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.ec2_sg]

  user_data = base64encode(file("${path.module}/user_data.sh"))

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.env}-bookstore-asg"
      Environment = var.env
      Project     = "online-bookstore"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.env}-asg"
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.public_subnet_ids
  target_group_arns         = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.bookstore_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.env}-bookstore-asg"
    propagate_at_launch = true
  }

  depends_on = [var.target_group_arn]
}

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.env}-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.env}-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

