data "aws_route53_zone" "hex7" {
  name = "hex7.com."
}


resource "aws_route53_record" "hashicode" {
  zone_id = data.aws_route53_zone.hex7.zone_id
  name    = "hashicode.hex7.com."
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.hashicode.domain_name
    zone_id                = aws_cloudfront_distribution.hashicode.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "hashicode" {
  domain_name       = "hashicode.hex7.com"
  validation_method = "EMAIL"

  validation_option {
    domain_name       = "hashicode.hex7.com"
    validation_domain = "hex7.com"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}
