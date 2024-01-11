resource "aws_apigatewayv2_domain_name" "hashicode" {
  domain_name = "${var.product}.hex7.com"

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.hashicode.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_route53_record" "hashicode" {
  name    = aws_apigatewayv2_domain_name.hashicode.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.hex7.zone_id

  alias {
    name                   = aws_apigatewayv2_domain_name.hashicode.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.hashicode.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}

data "aws_route53_zone" "hex7" {
  name         = "hex7.com."
  private_zone = false
}

resource "aws_acm_certificate" "hashicode" {
  domain_name       = "hashicode.hex7.com"
  validation_method = "EMAIL"

  validation_option {
    domain_name       = "hashicode.hex7.com"
    validation_domain = "hex7.com"
  }
}
