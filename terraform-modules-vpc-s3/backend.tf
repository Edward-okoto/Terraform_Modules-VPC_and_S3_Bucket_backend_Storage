terraform {
  backend "s3" {
    bucket  = "example-s3-bucket-2025"
    key     = "terraform/state"
    region  = "us-east-1"
    encrypt = true
  }
}