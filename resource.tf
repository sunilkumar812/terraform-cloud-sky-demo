# Create S3 bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "sktest-my-public-bucket-12345"
  acl    = "public-read"   # Grants public read access
}

# Optional: Allow public access via bucket policy
resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-public-bucket-12345/*"
    }
  ]
}
POLICY
}
