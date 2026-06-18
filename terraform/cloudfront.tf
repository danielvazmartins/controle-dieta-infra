resource "aws_cloudfront_distribution" "controle_dieta" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.controle_dieta_website.website_endpoint
    origin_id   = "controle-dieta-spa"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled = true
  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id = "controle-dieta-spa"
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # CachingOptimized
    viewer_protocol_policy = "redirect-to-https"
  }

  default_root_object = "index.html"
  
  custom_error_response {
    error_code = 404
    response_code = 200
    response_page_path = "/index.html"
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.controle_dieta.arn
    ssl_support_method = "sni-only"
  }

  depends_on = [aws_acm_certificate.controle_dieta]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}