variable "aws_region" {
  description = "AWS region to deploy the infrastructure."
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "A name for the project."
  type        = string
}

variable "cors_configuration_origins" {
  description = "The allowed origins for the cors configuration for the API Gateway. This will default to none."
  type        = list(string)
  default     = []
}
variable "cors_configuration_methods" {
  description = "The allowed methods for the cors configuration for the API Gateway. This will default to none."
  type        = list(string)
  default     = []
}
variable "cors_configuration_headers" {
  description = "The allowed headers for the cors configuration for the API Gateway. This will default to none."
  type        = list(string)
  default     = []
}
variable "cors_configuration_max_age" {
  description = "The max age for preflight requests for the cors configuration for the API Gateway. This will default to 300."
  type        = number
  default     = 300
}

variable "lambda_function_name" {
  description = "A name for the Lambda function."
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function."
  type        = string
  default     = "python3.8"
}

variable "lambda_timeout" {
  description = "Timeout in seconds for the Lambda function."
  type        = number
  default     = 3
}

variable "lambda_handler" {
  description = "The Lambda function entry point."
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_zip_file" {
  description = "Path to the zip file containing the Lambda function code."
  type        = string
}
variable "lambda_environment_variables" {
  description = "Environment variables for the lambda."
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  type        = number
  description = "The number of days to retain log events in the CloudWatch Logs Log Group."
  default     = 14
}

variable "lambda_vpc_config" {
  description = "VPC configuration for the Lambda function."
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = {
    security_group_ids = []
    subnet_ids         = []
  }
}

variable "api_route_method" {
  description = "The route method for the API Gateway."
  type        = string
  default     = "GET"
}

variable "api_route_path" {
  description = "The path for the API Gateway."
  type        = string
  default     = "/"

}
