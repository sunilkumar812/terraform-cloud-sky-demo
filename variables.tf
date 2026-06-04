variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "eventbridge_rule_name" {
  description = "EventBridge Rule Name"
  type        = string
}

variable "eventbridge_rule_description" {
  description = "EventBridge Rule Description"
  type        = string
}
