#Provider Configuration with AWS
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform-Team"
      Project     = var.project_name
    }
  }
}
