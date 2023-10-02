resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}_lambda_role"

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

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "get_method_lambda" {
  function_name    = var.lambda_function_name
  handler          = var.lambda_handler
  role             = aws_iam_role.lambda_role.arn
  runtime          = var.lambda_runtime
  source_code_hash = filebase64sha256(var.lambda_zip_file)
  timeout          = var.lambda_timeout
  filename         = var.lambda_zip_file
  dynamic "environment" {
    for_each = length(keys(var.lambda_environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.lambda_environment_variables
    }
  }
}

resource "aws_cloudwatch_log_group" "get_method_lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.get_method_lambda.function_name}"
  retention_in_days = var.log_retention_days
}

resource "aws_apigatewayv2_api" "get_method_api" {
  name          = "${var.project_name}_get_method_api"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = var.cors_configuration_origins
    allow_methods = var.cors_configuration_methods
    allow_headers = var.cors_configuration_headers
  }
}

resource "aws_apigatewayv2_integration" "get_method_lambda_integration" {
  api_id           = aws_apigatewayv2_api.get_method_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.get_method_lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "get_method_route" {
  api_id    = aws_apigatewayv2_api.get_method_api.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.get_method_lambda_integration.id}"
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_method_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.get_method_api.execution_arn}/*"
}

resource "aws_apigatewayv2_stage" "get_method_api_stage" {
  api_id      = aws_apigatewayv2_api.get_method_api.id
  name        = "default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_access_logs.arn
    format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId \"$context.identity.userAgent\" \"$context.identity.caller\" \"$context.identity.user\" $context.integrationStatus"
  }
}

resource "aws_cloudwatch_log_group" "api_gateway_access_logs" {
  name              = "${var.project_name}_api_gateway_access_logs"
  retention_in_days = var.log_retention_days
}
