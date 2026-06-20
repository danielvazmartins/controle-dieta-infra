resource "aws_acm_certificate" "controle_dieta" {
  domain_name       = var.domain_name_app
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "controle-dieta-cert"
  }
}

resource "aws_acm_certificate_validation" "controle_dieta" {
  certificate_arn = aws_acm_certificate.controle_dieta.arn
  timeouts {
    create = "5m"
  }
}

resource "aws_acm_certificate" "controle_dieta_api" {
  domain_name       = var.domain_name_api
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "controle-dieta-cert-api"
  }
}

resource "aws_acm_certificate_validation" "controle_dieta_api" {
  certificate_arn = aws_acm_certificate.controle_dieta_api.arn
  timeouts {
    create = "5m"
  }
}
