module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.1.0.0/16"
  subnet_cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24"]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "example-s3-bucket-2025" # Replace this with your preferred bucket name

  tags = {
    Name = "TerraformStateBucket"
  }
}

resource "aws_s3_bucket_policy" "state_bucket_policy" {
  bucket = aws_s3_bucket.state_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSpecificUserAccess"
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          "${aws_s3_bucket.state_bucket.arn}/*",
          aws_s3_bucket.state_bucket.arn
        ]
        Principal = {
          AWS = "arn:aws:iam::491085391064:user/Edward"
        }
      }
    ]
  })

  # Ensure bucket policy depends on bucket creation
  depends_on = [aws_s3_bucket.state_bucket]
}

output "bucket_name" {
  value = aws_s3_bucket.state_bucket.bucket
}