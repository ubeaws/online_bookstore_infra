output "high_cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "low_cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.low_cpu.alarm_name
}

