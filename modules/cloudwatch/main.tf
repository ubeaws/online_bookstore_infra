resource "aws_cloudwatch_log_group" "ec2_logs" {
  name              = "/ec2/${var.env}-bookstore"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.env}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This metric monitors high CPU usage"
  alarm_actions       = [] # Add SNS topic ARN if needed
  dimensions = {
    InstanceId = var.instance_id
  }
}

