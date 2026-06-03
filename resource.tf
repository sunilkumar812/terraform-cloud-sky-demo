# Create S3 bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "sktest-my-public-bucket-12345"
}
