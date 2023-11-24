#Cloudwatch for CPU usage resource

resource "aws_cloudwatch_metric_alarm" "portfolio_cpu_alarm" {
  alarm_name          = "portfolio-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 75
  alarm_description   = "Scale up if CPU utilization is above 75%"
  alarm_actions       = [aws_autoscaling_policy.portfolio_scale_up_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.portfolio_autoscaling_group.name
  }
}

#Autoscaling Policy resource

resource "aws_autoscaling_policy" "portfolio_scale_up_policy" {
  name                      = "portfolio-scale-up-policy"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 300
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
  autoscaling_group_name = aws_autoscaling_group.portfolio_autoscaling_group.name
}