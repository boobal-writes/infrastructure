resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = "mudivili-terraform-state-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state-bucket-server-side-encryption-configuration" {
  bucket = aws_s3_bucket.terraform-state-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform-state-bucket-key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "terraform-state-bucket-ownership-controls" {
  bucket = aws_s3_bucket.terraform-state-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "terraform-state-bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.terraform-state-bucket-ownership-controls]

  bucket = aws_s3_bucket.terraform-state-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform-state-bucket-versioning" {
  bucket = aws_s3_bucket.terraform-state-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform-state-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
