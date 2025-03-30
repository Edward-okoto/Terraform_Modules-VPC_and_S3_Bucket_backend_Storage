variable "bucket_name" {
  description = "Name of the S3 bucket"
}

variable "acl" {
  default = "private"
  description = "Access control for the bucket"
}

resource "aws_s3_bucket" "main_bucket" {
  bucket = var.bucket_name
  acl    = var.acl
  tags = {
    Name = "MainBucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.main_bucket.bucket
}