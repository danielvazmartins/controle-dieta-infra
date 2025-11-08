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
  aliases = ["controle-dieta.danielvazmartins.com.br"]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id = "controle-dieta-spa"
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # CachingOptimized
    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:189956367266:certificate/c12e6a81-f810-44c6-8fd0-21635b84add8"
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}