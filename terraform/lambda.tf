resource "aws_lambda_function" "controle_dieta_backend" {
  function_name = "controle-dieta-backend"
  role          = aws_iam_role.controle_dieta_lambda_backend_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  filename      = "${path.module}/lambda/controle-dieta-lambda.zip"
}

resource "aws_iam_role" "controle_dieta_lambda_backend_role" {
  name = "controle-dieta-lambda-backend-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_permission" "api_gateway_openapi_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.controle_dieta_backend.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:us-east-1:615897050135:i3lkrd0cm2/*/*"
  
}