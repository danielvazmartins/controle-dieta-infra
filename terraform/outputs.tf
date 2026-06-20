output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.controle_dieta.domain_name
}

output "cloudfront_domain_alias" {
  description = "Cloudfront domain alias"
  value = aws_cloudfront_distribution.controle_dieta.aliases
}

output "api_gateway_custom_domain" {
  description = "Custom domain name used by the API Gateway"
  value       = aws_api_gateway_domain_name.controle_dieta_openapi.domain_name
}

output "api_gateway_custom_domain_base_url" {
  description = "Base URL for the custom API Gateway domain"
  value       = "https://${aws_api_gateway_domain_name.controle_dieta_openapi.domain_name}"
}

output "api_gateway_invoke_url" {
  description = "Invoke URL for the mock API Gateway endpoint"
  value       = "https://${aws_api_gateway_rest_api.controle_dieta_api.id}.execute-api.${data.aws_region.current.region}.amazonaws.com/${aws_api_gateway_stage.controle_dieta_stage.stage_name}/mock"
}