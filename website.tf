resource "aws_s3_bucket" "hashicode"{
  bucket        = var.bucket
  force_destroy = true
  tags          = var.tags
}


resource "aws_s3_bucket_versioning" "hashicode" {
  bucket = aws_s3_bucket.hashicode.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_public_access_block" "hashicode" {
  bucket                  = aws_s3_bucket.hashicode.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "hashicode" {
  depends_on = [
    aws_s3_bucket_ownership_controls.hashicode,
    aws_s3_bucket_public_access_block.hashicode
  ]
  bucket = aws_s3_bucket.hashicode.id
  acl    = "public-read"
}


resource "aws_s3_bucket_website_configuration" "hashicode" {
  bucket = aws_s3_bucket.hashicode.id
  index_document { suffix = "index.html" }
}


resource "aws_s3_bucket_policy" "hashicode" {
  bucket = aws_s3_bucket.hashicode.id
  policy = data.aws_iam_policy_document.hashicode.json
}


data "aws_iam_policy_document" "hashicode" {
  statement {
    sid    = "AllowPublicRead"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.bucket}",
      "arn:aws:s3:::${var.bucket}/*",
    ]
    actions = ["S3:Get*", "S3:List*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}


resource "aws_s3_bucket_ownership_controls" "hashicode" {
  bucket = aws_s3_bucket.hashicode.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_object" "hashicode" {
  bucket           = aws_s3_bucket.hashicode.id
  key              = "index.html"
  source           = "index.html"
  source_hash      = filemd5("index.html")
  acl              = "public-read"
  content_type     = "text/html"
  content_language = "en-US"
  tags             = var.tags
}


output "hashicode_site_version" {
  value = aws_s3_object.hashicode.version_id
}

output "hashicorp_s3_domain" {
  value = aws_s3_bucket.hashicode.bucket_domain_name
}

output "hashicode_s3_regional_domain" {
  value = aws_s3_bucket.hashicode.bucket_regional_domain_name
}


output "hashicorp_s3_acl" {
  value = aws_s3_object.hashicode.acl
}
output "hashicorp_s3_crc32" { 
  value = aws_s3_object.hashicode.checksum_crc32
}
output "hashicorp_s3_crc32c" { 
  value = aws_s3_object.hashicode.checksum_crc32c
}
output "hashicorp_s3_sha1" { 
  value = aws_s3_object.hashicode.checksum_sha1
}
output "hashicorp_s3_sha256" { 
  value = aws_s3_object.hashicode.checksum_sha256
}
output "hashicorp_s3_etag" { 
  value = aws_s3_object.hashicode.etag
}
