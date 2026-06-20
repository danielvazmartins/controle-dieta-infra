resource "aws_api_gateway_rest_api" "controle_dieta_api" {
  name        = "controle-dieta-api"
  description = "API Gateway mock endpoint for SPA infrastructure"
}

resource "aws_api_gateway_resource" "mock" {
  rest_api_id = aws_api_gateway_rest_api.controle_dieta_api.id
  parent_id   = aws_api_gateway_rest_api.controle_dieta_api.root_resource_id
  path_part   = "mock"
}

resource "aws_api_gateway_method" "mock_get" {
  rest_api_id   = aws_api_gateway_rest_api.controle_dieta_api.id
  resource_id   = aws_api_gateway_resource.mock.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "mock_get" {
  rest_api_id             = aws_api_gateway_rest_api.controle_dieta_api.id
  resource_id             = aws_api_gateway_resource.mock.id
  http_method             = aws_api_gateway_method.mock_get.http_method
  type                    = "MOCK"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_method_response" "mock_get_200" {
  rest_api_id = aws_api_gateway_rest_api.controle_dieta_api.id
  resource_id = aws_api_gateway_resource.mock.id
  http_method = aws_api_gateway_method.mock_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "mock_get_200" {
  rest_api_id = aws_api_gateway_rest_api.controle_dieta_api.id
  resource_id = aws_api_gateway_resource.mock.id
  http_method = aws_api_gateway_method.mock_get.http_method
  status_code = aws_api_gateway_method_response.mock_get_200.status_code
  depends_on = [aws_api_gateway_integration.mock_get]

  response_templates = {
    "application/json" = file("${path.module}/api/mock/get_mock_response.json")
  }
}

resource "aws_api_gateway_deployment" "controle_dieta" {
  rest_api_id = aws_api_gateway_rest_api.controle_dieta_api.id
  depends_on  = [aws_api_gateway_integration_response.mock_get_200]

  # Força um novo deployment sempre que houver mudanças em qualquer recurso da API
  triggers = {
    redeploy = sha1(jsonencode({
      resource              = aws_api_gateway_resource.mock.id
      method                = aws_api_gateway_method.mock_get.id
      integration           = aws_api_gateway_integration.mock_get.id
      integration_response  = aws_api_gateway_integration_response.mock_get_200.id
      response_template     = filesha1("${path.module}/api/mock/get_mock_response.json")
    }))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "controle_dieta_stage" {
  stage_name    = "old"
  rest_api_id   = aws_api_gateway_rest_api.controle_dieta_api.id
  deployment_id = aws_api_gateway_deployment.controle_dieta.id
}
