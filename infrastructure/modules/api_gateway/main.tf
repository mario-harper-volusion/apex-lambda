resource "aws_api_gateway_rest_api" "foo_api" {
  name = "foo_api"
  description = "This API was created using terraform :)"
}

# Resource
# /foo
resource "aws_api_gateway_resource" "foo_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.foo_api.id}"
  parent_id = "${aws_api_gateway_rest_api.foo_api.root_resource_id}"
  path_part = "foo"
}

# Method
# GET /foo
resource "aws_api_gateway_method" "foo_get_endpoint_method" {
  rest_api_id = "${aws_api_gateway_rest_api.foo_api.id}"
  resource_id = "${aws_api_gateway_resource.foo_resource.id}"
  http_method = "GET"
  authorization = "NONE"
}

# Method Response
resource "aws_api_gateway_method_response" "200" {
  rest_api_id = "${aws_api_gateway_rest_api.foo_api.id}"
  resource_id = "${aws_api_gateway_resource.foo_resource.id}"
  http_method = "${aws_api_gateway_method.foo_get_endpoint_method.http_method}"
  status_code = "200"
}


# Integration
# GET /foo -> lambda
resource "aws_api_gateway_integration" "foo_get_endpoint_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.foo_api.id}"
  resource_id = "${aws_api_gateway_resource.foo_resource.id}"
  http_method = "${aws_api_gateway_method.foo_get_endpoint_method.http_method}"
  type = "AWS"
  credentials = "${var.gateway_invoke_lambda_role_arn}"
  # Must be POST for invoking Lambda function
  integration_http_method = "POST"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:apex-lambda_hello/invocations"
  request_templates = {
    "application/json" = "${file("${path.module}/api_gateway_body_mapping.template")}"
  }
}

# Integration -> *Integration Response* -> Method Response -> Client
resource "aws_api_gateway_integration_response" "foo_get_endpoint_integration_response" {
  rest_api_id = "${aws_api_gateway_rest_api.foo_api.id}"
  resource_id = "${aws_api_gateway_resource.foo_resource.id}"
  http_method = "${aws_api_gateway_method.foo_get_endpoint_method.http_method}"
  status_code = "${aws_api_gateway_method_response.200.status_code}"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on=[
    "aws_api_gateway_integration.foo_get_endpoint_integration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.foo_api.id}"
  stage_name = "${var.api_stage}"
  variables = {
    "functionAlias" = "${var.api_stage}"
  }
}