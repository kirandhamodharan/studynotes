resource "aws_api_gateway_rest_api" "vpctools_api_gateway" {
  name        = "vpctools"
  description = "VPCTOOLS"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "randomcidr_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.vpctools_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.vpctools_api_gateway.root_resource_id
  path_part   = "randomcidr"
}

resource "aws_api_gateway_method" "randomcidr_get_method" {
  rest_api_id        = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id        = aws_api_gateway_resource.randomcidr_api_resource.id
  http_method        = "GET"
  authorization      = "NONE"
  request_parameters = {}
}

resource "aws_api_gateway_method_response" "randomcidr_get_method_response_200" {
  rest_api_id         = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id         = aws_api_gateway_resource.randomcidr_api_resource.id
  http_method         = aws_api_gateway_method.randomcidr_get_method.http_method
  status_code         = "200"
  response_parameters = {}
  response_models = {
    "application/json" : "Empty"
  }
}

resource "aws_api_gateway_integration" "randomcidr_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id             = aws_api_gateway_resource.randomcidr_api_resource.id
  http_method             = aws_api_gateway_method.randomcidr_get_method.http_method
  integration_http_method = "POST"
  content_handling        = "CONVERT_TO_TEXT"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.vpctools_lambda.invoke_arn
}

resource "aws_api_gateway_integration_response" "randomcidr_integration_response" {
  depends_on = [aws_api_gateway_rest_api.vpctools_api_gateway, aws_api_gateway_integration.randomcidr_lambda_integration]

  rest_api_id = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id = aws_api_gateway_resource.randomcidr_api_resource.id
  http_method = aws_api_gateway_method.randomcidr_get_method.http_method
  status_code = aws_api_gateway_method_response.randomcidr_get_method_response_200.status_code
  response_templates = {
    "application/json" : ""
  }
}

#***************************
resource "aws_api_gateway_resource" "splitvpc_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.vpctools_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.vpctools_api_gateway.root_resource_id
  path_part   = "splitvpc"
}

resource "aws_api_gateway_method" "splitvpc_post_method" {
  rest_api_id        = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id        = aws_api_gateway_resource.splitvpc_api_resource.id
  http_method        = "POST"
  authorization      = "NONE"
  request_parameters = {}
}

resource "aws_api_gateway_method_response" "splitvpc_post_method_response_200" {
  rest_api_id         = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id         = aws_api_gateway_resource.splitvpc_api_resource.id
  http_method         = aws_api_gateway_method.splitvpc_post_method.http_method
  status_code         = "200"
  response_parameters = {}
  response_models = {
    "application/json" : "Empty"
  }
}

resource "aws_api_gateway_integration" "splitvpc_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id             = aws_api_gateway_resource.splitvpc_api_resource.id
  http_method             = aws_api_gateway_method.splitvpc_post_method.http_method
  integration_http_method = "POST"
  content_handling        = "CONVERT_TO_TEXT"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.vpctools_lambda.invoke_arn
}
resource "aws_api_gateway_integration_response" "splitvpc_integration_response" {
  depends_on = [aws_api_gateway_rest_api.vpctools_api_gateway, aws_api_gateway_integration.splitvpc_lambda_integration]

  rest_api_id = aws_api_gateway_rest_api.vpctools_api_gateway.id
  resource_id = aws_api_gateway_resource.splitvpc_api_resource.id
  http_method = aws_api_gateway_method.splitvpc_post_method.http_method
  status_code = aws_api_gateway_method_response.splitvpc_post_method_response_200.status_code
  response_templates = {
    "application/json" : ""
  }
}
#****************************



#****************************

resource "aws_api_gateway_deployment" "vpctools_deployment" {
  depends_on = [aws_api_gateway_integration.randomcidr_lambda_integration, aws_api_gateway_integration.splitvpc_lambda_integration]

  rest_api_id = aws_api_gateway_rest_api.vpctools_api_gateway.id
  stage_name  = "v1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowVPCTOOLSAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "vpctools"
  principal     = "apigateway.amazonaws.com"

  # The / * / * / * part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.vpctools_api_gateway.execution_arn}/*/*/*"
}


