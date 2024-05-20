# Resources = Bucket resource
resource "aws_s3_bucket" "mbandi_dev_bucket" {
  bucket = "mbandi-dev-bucket-126543279054"
  region = "us-west-1"
  tags = {
    Environment = "dev"
    CostCenter  = "cc590"
  }
}
