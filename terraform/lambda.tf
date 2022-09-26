# START LAMBDA FOR PROCESSING getAndIncrement FROM API GATEWAY
# START LAMBDA FOR PROCESSING getAndIncrement FROM API GATEWAY
data "archive_file" "zip_aorlowski_lambda" {
    type = "zip"
    # TODO: Replace hardcoded paths with variables
    source_file = "${local.path_to_backend}lambda.py"
    output_path = "${local.path_to_backend}lambda.zip"
}

# START Lambda Function
resource "aws_lambda_function" "aorlowski_getAndIncrement_lambda" {
    filename      = data.archive_file.zip_aorlowski_lambda.output_path
    function_name = "aorlowski-get-viewer-count-and-increment"
    role          = aws_iam_role.aorlowski_getAndIncrement_lambda_role.arn
    handler       = "lambda.lambda_handler"
    runtime       = "python3.9"

    # TODO: Replace hardcoded paths with variables
    source_code_hash = filebase64sha256("${local.path_to_backend}lambda.py")
}
# END Lambda Function

# START CloudWatch Log Group for Lambda
module "lambda_log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "/aws/lambda/aorlowski-get-viewer-count-and-increment"
  retention_in_days = 14
}
# END CloudWatch Log Group for Lambda

# START ROLE FOR LAMBDA
resource "aws_iam_role" "aorlowski_getAndIncrement_lambda_role" {
    name = "getAndIncrement_lambda_role"

    assume_role_policy = <<POLICY
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
    POLICY
}
# END ROLE FOR LAMBDA

# POLICY TO ALLOW LAMBDA ROLE ACCESS TO DYNAMODB
resource "aws_iam_policy" "aorlowski_lambda_dynamodb_access" {
    name = "aorlowski_lambda_dynamodb_access"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Action": [
            "dynamodb:GetItem",
            "dynamodb:UpdateItem",
            "dynamodb:PutItem"
        ],
        "Resource": "${aws_dynamodb_table.dynamodb_statistics_table.arn}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
        ],
        "Resource": "${module.lambda_log_group.cloudwatch_log_group_arn}:*"
        }
    ]
}
EOF
}

# ATTACH ABOVE POLICY TO ABOVE ROLE
resource "aws_iam_policy_attachment" "lambda_dynamodb_access" {
    name = "lambda_dynamodb_access"
    roles = [aws_iam_role.aorlowski_getAndIncrement_lambda_role.name]
    policy_arn = aws_iam_policy.aorlowski_lambda_dynamodb_access.arn
}

# START LAMBDA PERMISSION TO ALLOW EXECUTION FROM API GATEWAY POST
resource "aws_lambda_permission" "apigw_lambda_post" {
    statement_id  = "AllowExecutionFromAPIGatewayPost"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.aorlowski_getAndIncrement_lambda.function_name
    principal     = "apigateway.amazonaws.com"

    # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
    source_arn = "arn:aws:execute-api:us-east-2:${var.accountId}:${aws_api_gateway_rest_api.aorlowski_rest_api.id}/*/${aws_api_gateway_method.aorlowski_visitor_getAndIncrement_method.http_method}${aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.path}"
}
# END LAMBDA PERMISSION TO ALLOW EXECUTION FROM API GATEWAY POST

# START LAMBDA PERMISSION TO ALLOW EXECUTION FROM API GATEWAY GET
resource "aws_lambda_permission" "apigw_lambda_get" {
    statement_id  = "AllowExecutionFromAPIGatewayGet"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.aorlowski_getAndIncrement_lambda.function_name
    principal     = "apigateway.amazonaws.com"

    # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
    source_arn = "arn:aws:execute-api:us-east-2:${var.accountId}:${aws_api_gateway_rest_api.aorlowski_rest_api.id}/*/${aws_api_gateway_method.aorlowski_visitor_get_method.http_method}${aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.path}"
}
# END LAMBDA PERMISSION TO ALLOW EXECUTION FROM API GATEWAY GET

# END LAMBDA FOR PROCESSING getAndIncrement FROM API GATEWAY
# END LAMBDA FOR PROCESSING getAndIncrement FROM API GATEWAY