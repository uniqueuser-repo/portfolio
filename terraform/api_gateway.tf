# START API GATEWAY
# START API GATEWAY
resource "aws_api_gateway_rest_api" "aorlowski_rest_api" {
    provider = aws.east-1
    name = "aorlowski-rest-api"
    description = "A REST API for everything backend-related to aorlowski.com"
    put_rest_api_mode = "overwrite"

    endpoint_configuration {
      types = [
          "REGIONAL"
      ]
    }
}

# START getAndIncrement endpoint
resource "aws_api_gateway_resource" "aorlowski_visitor_getAndIncrement_resource" {
    provider = aws.east-1
    parent_id = aws_api_gateway_rest_api.aorlowski_rest_api.root_resource_id
    path_part = "viewerCount_getAndIncrement"
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
}

# START METHOD POST on /viewerCount_getAndIncrement
resource "aws_api_gateway_method" "aorlowski_visitor_getAndIncrement_method" {
    provider = aws.east-1
    authorization = "NONE"
    http_method = "POST"
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
}
# END METHOD POST on /viewerCount_getAndIncrement

# START METHOD POST on /viewerCount_getAndIncrement INTEGRATION WITH LAMBDA
resource "aws_api_gateway_integration" "aorlowski_visitor_getAndIncrement_integration" {
    provider = aws.east-1
    http_method = aws_api_gateway_method.aorlowski_visitor_getAndIncrement_method.http_method
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    type = "AWS_PROXY"
    integration_http_method = "POST"
    uri = aws_lambda_function.aorlowski_getAndIncrement_lambda.invoke_arn
}
# END METHOD POST on /viewerCount_getAndIncrement INTEGRATION WITH LAMBDA

# START METHOD GET on /viewerCount_getAndIncrement
resource "aws_api_gateway_method" "aorlowski_visitor_get_method" {
    provider = aws.east-1
    authorization = "NONE"
    http_method = "GET"
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
}
# END METHOD GET on /viewerCount_getAndIncrement

# START METHOD GET on /viewerCount_getAndIncrement INTEGRATION WITH LAMBDA
resource "aws_api_gateway_integration" "aorlowski_visitor_get_integration" {
    provider = aws.east-1
    http_method = aws_api_gateway_method.aorlowski_visitor_get_method.http_method
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    type = "AWS_PROXY"
    integration_http_method = "POST"
    uri = aws_lambda_function.aorlowski_getAndIncrement_lambda.invoke_arn
}
# END METHOD GET on /viewerCount_getAndIncrement INTEGRATION WITH LAMBDA

resource "aws_api_gateway_account" "demo" {
    provider = aws.east-1
    cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}

resource "aws_iam_role" "cloudwatch" {
    provider = aws.east-1
    name = "api_gateway_cloudwatch_global"

    assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Sid": "",
    "Effect": "Allow",
    "Principal": {
        "Service": "apigateway.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
    }
]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch" {
    provider = aws.east-1
    name = "default"
    role = aws_iam_role.cloudwatch.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# START throttling settings for API Gateway
resource "aws_api_gateway_method_settings" "settings" {
    provider = aws.east-1
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    stage_name  = aws_api_gateway_stage.aorlowski_production_stage.stage_name
    method_path = "*/*"

    settings {
        # Set throttling values
        throttling_burst_limit = 3
        throttling_rate_limit  = 5

        # Enable logging
        metrics_enabled = true
        logging_level = "ERROR"
    }
}
# END throttling settings for API Gateway
# End getAndIncrement endpoint

# START API Gateway production deployment
resource "aws_api_gateway_deployment" "aorlowski_rest_api_deployment" {
    provider = aws.east-1
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    triggers = {
        redeployment = sha1(jsonencode(aws_api_gateway_rest_api.aorlowski_rest_api.body))
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = [
        aws_api_gateway_method.aorlowski_visitor_getAndIncrement_method,
        aws_api_gateway_integration.aorlowski_visitor_getAndIncrement_integration,
        aws_lambda_function.aorlowski_getAndIncrement_lambda,
        aws_api_gateway_method.aorlowski_visitor_get_method,
        aws_api_gateway_integration.aorlowski_visitor_get_integration
    ]
}
# END API Gateway production deployment

# START API Gateway production stage
resource "aws_api_gateway_stage" "aorlowski_production_stage" {
    provider = aws.east-1
    deployment_id = aws_api_gateway_deployment.aorlowski_rest_api_deployment.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    stage_name = "aorlowski_production"
} 
# END API Gateway production stage

# END API GATEWAY
# END API GATEWAY