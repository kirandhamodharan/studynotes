
resource "aws_iam_role" "vpctools_lambda_role" {
  name        = "vpctools_lambda_role"
  description = "Role assumed by the lambda function"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "vpctools_lambda_role_policy_attach" {
  role       = aws_iam_role.vpctools_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "vpctools_lambda" {
  filename         = "lambda_src.zip"
  function_name    = "vpctools"
  description      = "VPCTOOLS"
  role             = aws_iam_role.vpctools_lambda_role.arn
  handler          = "main.handler"
  source_code_hash = filebase64sha256("lambda_src.zip")

  runtime = "nodejs12.x"
}