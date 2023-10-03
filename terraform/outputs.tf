output "api_gateway_id" {
  value       = aws_apigatewayv2_api.get_method_api.id
  description = "The id of the API Gateway"
}

output "api_gateway_invoke_url" {
  value       = "${aws_apigatewayv2_api.get_method_api.api_endpoint}/default/"
  description = "The base URL to invoke the API Gateway"
}

output "api_gateway_execution_arn" {
  value       = aws_apigatewayv2_api.get_method_api.execution_arn
  description = "The execution arn for the API Gateway"
}

output "api_gateway_arn" {
  value       = aws_apigatewayv2_api.get_method_api.arn
  description = "The ARN of the API Gateway"
}

output "lambda_function_name" {
  value       = aws_lambda_function.get_method_lambda.function_name
  description = "The name of the Lambda function"
}

output "lambda_function_arn" {
  value       = aws_lambda_function.get_method_lambda.arn
  description = "The ARN of the Lambda function"
}

output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.get_method_lambda_log_group.name
  description = "The name of the CloudWatch Logs Log Group for the Lambda function"
}

output "api_gateway_access_logs_log_group_name" {
  value       = aws_cloudwatch_log_group.api_gateway_access_logs.name
  description = "The name of the CloudWatch Logs Log Group for the API Gateway access logs"
}

output "lambda_role_name" {
  value       = aws_iam_role.lambda_role.name
  description = "The name of the IAM role for the created Lambda"
}

output "lambda_role_arn" {
  value       = aws_iam_role.lambda_role.arn
  description = "The ARN of the IAM role for the created Lambda"
}
