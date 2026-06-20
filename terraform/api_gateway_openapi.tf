resource "aws_api_gateway_rest_api" "controle_dieta_api_openapi" {
  name        = "controle-dieta-api-openapi"
  description = "API Gateway criado a partir de OpenAPI 3 para a aplicação de dietas"
  body        = file("${path.module}/api/openapi-diet.yaml")
}

resource "aws_api_gateway_deployment" "controle_dieta_openapi" {
  rest_api_id = aws_api_gateway_rest_api.controle_dieta_api_openapi.id

  # Força um novo deployment sempre que o arquivo OpenAPI mudar
  triggers = {
    redeploy = sha1(file("${path.module}/api/openapi-diet.yaml"))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "controle_dieta_openapi_stage" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.controle_dieta_api_openapi.id
  deployment_id = aws_api_gateway_deployment.controle_dieta_openapi.id
}

resource "aws_api_gateway_domain_name" "controle_dieta_openapi" {
  domain_name     = var.domain_name_api
  certificate_arn = aws_acm_certificate.controle_dieta_api.arn

  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_api_gateway_base_path_mapping" "controle_dieta_openapi" {
  api_id = aws_api_gateway_rest_api.controle_dieta_api_openapi.id
  stage_name  = aws_api_gateway_stage.controle_dieta_openapi_stage.stage_name
  domain_name = aws_api_gateway_domain_name.controle_dieta_openapi.domain_name
  base_path   = ""
}
