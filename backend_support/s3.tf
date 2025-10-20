resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.prefix}-tfstate"

  tags = {
    Name = format("%s-tfstate", var.prefix)}
}

//Enable bucket versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "tfstate_bucket_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

//Ensure that all public access is blocked
resource "aws_s3_bucket_public_access_block" "tfstate_bucket_public_access_block" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

//Ensure that the S3 bucket is using encryption algorithm AES256
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_bucket_encryption" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
 