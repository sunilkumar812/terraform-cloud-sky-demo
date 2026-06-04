#EventBridge Rule
resource "aws_cloudwatch_event_rule" "aws_health" {

  name = "${var.environment}-aws-health-events"

  description = "Capture AWS Health Events"

  event_pattern = jsonencode({
  source = [
    "aws.health",
    "custom.health.test"
  ]
})
}

#EventBridge Target
resource "aws_cloudwatch_event_target" "lambda_target" {

  rule = aws_cloudwatch_event_rule.aws_health.name

  arn = aws_lambda_function.health_processor.arn
}

#Lambda Permission
resource "aws_lambda_permission" "allow_eventbridge" {

  statement_id = "AllowExecutionFromEventBridge"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.health_processor.function_name

  principal = "events.amazonaws.com"

  source_arn = aws_cloudwatch_event_rule.aws_health.arn
}
