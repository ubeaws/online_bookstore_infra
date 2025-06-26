resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.env}-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm when CPU > 70%"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = [var.scale_out_policy_arn]
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${var.env}-low-cpu-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Alarm when CPU < 30%"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = [var.scale_in_policy_arn]
}

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.env}-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.env}-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.asg_name
}

