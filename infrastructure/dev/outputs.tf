output "dev_api_invoke_url" {
  value = "${module.api_gateway.api_invoke_url}"
}

output "lambda_function_role_id" {
  value = "${module.iam.lambda_function_role_id}"
}