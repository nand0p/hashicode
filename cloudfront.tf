resource "aws_cloudfront_distribution" "hashicode" {
  origin {
    domain_name              = aws_s3_bucket.hashicode.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.hashicode.id
    origin_id                = "hashicode"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "GreenUP"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "hashicode-logs.s3.amazonaws.com"
    prefix          = "cloudfront"
  }

  aliases = ["hashicode.hex7.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "hashicode"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 300
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.hashicode.arn
    ssl_support_method  = "sni-only"
  }

  tags = var.tags
}

resource "aws_cloudfront_origin_access_control" "hashicode" {
  name                              = "hashicode"
  description                       = "HashiCode Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
