resource "aws_api_gateway_base_path_mapping" "test" {
  api_id      = aws_api_gateway_rest_api.vpctools_api_gateway.id
  stage_name  = aws_api_gateway_deployment.vpctools_deployment.stage_name
  domain_name = "api.cloudtechbits.com"
}