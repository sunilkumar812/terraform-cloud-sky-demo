#Create ZIP Package
data "archive_file" "lambda_zip" {

  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"

  output_path = "${path.module}/lambda/lambda_function.zip"
}

#IAM Role
resource "aws_iam_role" "lambda_role" {

  name = "${var.environment}-health-event-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Create Policy for read tags from lambda ARN
resource "aws_iam_role_policy" "lambda_tag_reader" {

  name = "lambda-tag-reader"

  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "lambda:ListTags",
          "lambda:GetFunction"
        ]

        Resource = "*"
      }
    ]
  })
}
# CloudWatch Logging Policy
resource "aws_iam_role_policy_attachment" "basic_execution" {

  role       = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {

  name = "/aws/lambda/${var.environment}-health-event-processor"

  retention_in_days = 30
}

#Lambda Function
resource "aws_lambda_function" "health_processor" {

  function_name = "${var.environment}-health-event-processor"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.13"

  handler = "lambda_function.lambda_handler"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout = 30

  memory_size = 128
}

#
