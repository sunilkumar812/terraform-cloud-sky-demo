resource "aws_cloudwatch_event_rule" "aws_health_events" {

  name        = var.eventbridge_rule_name
  description = var.eventbridge_rule_description

  event_pattern = jsonencode({
    source = [
      "aws.health"
    ]
  })
}
