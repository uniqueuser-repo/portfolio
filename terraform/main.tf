terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "accountId" {
  type = string
}

data "aws_canonical_user_id" "current_user" {}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

provider "aws" {
    alias = "east-1"
    region = "us-east-1"
}

locals {
    root_domain_str = "aorlowski.com"
    subdomain_str = "www.aorlowski.com"
    all_subdomains_str = "*.aorlowski.com"
}

# START ROOT DOMAIN BUCKET
# START ROOT DOMAIN BUCKET
resource "aws_s3_bucket" "root-domain" {
    bucket = local.root_domain_str
    policy = jsonencode(
        {
            Statement = [
                {
                    Action    = "s3:GetObject"
                    Effect    = "Allow"
                    Principal = "*"
                    Resource  = "arn:aws:s3:::aorlowski.com/*"
                    Sid       = "PublicReadGetObject"
                },
            ]
            Version   = "2012-10-17"
        }
    )

}

resource "aws_s3_bucket_acl" "root-domain-bucket-acl" {
    bucket = aws_s3_bucket.root-domain.id
    access_control_policy {
      grant {
          grantee {
              id = data.aws_canonical_user_id.current_user.id
              type = "CanonicalUser"
          }
          permission = "FULL_CONTROL"
      }

      owner {
          id = data.aws_canonical_user_id.current_user.id
      }
    }
}

resource "aws_s3_bucket_website_configuration" "root-domain-bucket-website-config" {
    bucket = aws_s3_bucket.root-domain.id

    index_document {
      suffix = "index.html"
    }
}

# When we upload the build to S3, we need to make sure each individual Object uploaded has the correct content-type associated.
# If not specified, all files are uploaded as "application/octet-stream", which is definitely wrong and will cause problems.
# We can use a dictionary (seen below) to look up the content type of a file as we process each of them in the aws_s3_bucket_object.upload_build resource.
locals {
  mime_types = {
    "css"  = "text/css"
    "html" = "text/html"
    "ico"  = "image/vnd.microsoft.icon"
    "js"   = "application/javascript"
    "json" = "application/json"
    "map"  = "application/json"
    "png"  = "image/png"
    "svg"  = "image/svg+xml"
    "txt"  = "text/plain"
    "webp" = "image/webp"
    "ttf" = "application/octet-stream"
    "jpg" = "image/jpeg"
    "jpeg" = "image/jpeg"
    "woff" = "font/woff"
    "eot" = "application/vnd.ms"
  }
}

locals {
    build_dir = "/mnt/c/Users/Andy/Desktop/portfolio/build/"
}

resource "aws_s3_bucket_object" "upload_build" {
    for_each = fileset(local.build_dir, "**")

    bucket = aws_s3_bucket.root-domain.bucket
    key = each.value
    source = "${local.build_dir}${each.value}"

    # Determine the content type by getting the extension of the file and searching dor it in the map
    content_type = lookup(tomap(local.mime_types), element(split(".", each.value), length(split(".", each.value)) - 1))

    etag = filemd5("${local.build_dir}${each.value}")
}
# END ROOT DOMAIN BUCKET
# END ROOT DOMAIN BUCKET


# START SUBDOMAIN (WWW.) BUCKET
# START SUBDOMAIN (WWW.) BUCKET
resource "aws_s3_bucket" "subdomain-www" {
    bucket = local.subdomain_str
    policy = jsonencode(
        {
            Statement = [
                {
                    Action    = "s3:GetObject"
                    Effect    = "Allow"
                    Principal = "*"
                    Resource  = "arn:aws:s3:::www.aorlowski.com/*"
                    Sid       = "PublicReadGetObject"
                },
            ]
            Version   = "2012-10-17"
        }
    )
}

resource "aws_s3_bucket_acl" "subdomain-www-bucket-acl" {
    bucket = aws_s3_bucket.subdomain-www.id
    access_control_policy {
      grant {
          grantee {
              id = data.aws_canonical_user_id.current_user.id
              type = "CanonicalUser"
          }
          permission = "FULL_CONTROL"
      }

      owner {
          id = data.aws_canonical_user_id.current_user.id
      }
    }
}

resource "aws_s3_bucket_website_configuration" "subdomain-www-bucket-website-config" {
    bucket = aws_s3_bucket.subdomain-www.id

    redirect_all_requests_to {
      host_name = local.subdomain_str
      protocol = "http"
    }
}
# END SUBDOMAIN (WWW.) BUCKET
# END SUBDOMAIN (WWW.) BUCKET

# START CLOUDFRONT DISTRIBUTION FOR *aorlowski.com
# START CLOUDFRONT DISTRIBUTION FOR *aorlowski.com
resource "aws_cloudfront_distribution" "aorlowski_s3_distribution" {
    origin {
        domain_name = aws_s3_bucket.root-domain.bucket_regional_domain_name
        origin_id = aws_s3_bucket.root-domain.bucket_regional_domain_name
        connection_attempts = 3
        connection_timeout = 10
    }

    enabled = true
    is_ipv6_enabled = true
    default_root_object = "index.html"

    aliases = [
        local.all_subdomains_str,
        local.root_domain_str
    ]
    

    default_cache_behavior {
      allowed_methods = [
          "GET",
          "HEAD"
      ]

      cached_methods = [
          "GET",
          "HEAD"
      ]

      forwarded_values {
        query_string = false

        cookies {
            forward = "none"
        }
      }

      target_origin_id = aws_s3_bucket.root-domain.bucket_regional_domain_name
      viewer_protocol_policy = "redirect-to-https"
      compress = true
    }

    viewer_certificate {
      acm_certificate_arn = aws_acm_certificate.certificate.arn
      cloudfront_default_certificate = false
      iam_certificate_id = ""
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method =  "sni-only"
    }

    price_class = "PriceClass_100"
    restrictions {
        geo_restriction {
          restriction_type = "none"
        }
    }
}
# END CLOUDFRONT DISTRIBUTION FOR *aorlowski.com
# END CLOUDFRONT DISTRIBUTION FOR *aorlowski.com

# I don't want Terraform to manage the hosted zone, so I will leave it hardcoded.
locals {
  hosted_zone_id = "Z02236511VLB1LAPEVX01"
}

# Start Route 53 Record for aorlowski.com to have an A Record to the CloudFront distribution
resource "aws_route53_record" "aorlowski_cloudfront_record" {
    zone_id = local.hosted_zone_id
    name = local.root_domain_str
    type = "A"

    alias {
        name = aws_cloudfront_distribution.aorlowski_s3_distribution.domain_name
        zone_id = aws_cloudfront_distribution.aorlowski_s3_distribution.hosted_zone_id
        evaluate_target_health = false
    }

    allow_overwrite = true
}
# End Route 53 Record for aorlowski.com to have an A Record to the CloudFront distribution

# Start Route 53 Record for www.aorlowski.com to have an A Record to the CloudFront distribution
resource "aws_route53_record" "wwww_aorlowski_cloudfront_record" {
    # I don't want Terraform to manage the hosted zone, so I will leave this hard coded.
    zone_id = local.hosted_zone_id
    name = local.subdomain_str
    type = "A"

    alias {
        name = aws_cloudfront_distribution.aorlowski_s3_distribution.domain_name
        zone_id = aws_cloudfront_distribution.aorlowski_s3_distribution.hosted_zone_id
        evaluate_target_health = false
    }

    allow_overwrite = true
}
# End Route 53 Record for www.aorlowski.com to have an A Record to the CloudFront distribution



# START CERTIFICATE FOR *aorlowski.com
# START CERTIFICATE FOR *aorlowski.com
resource "aws_acm_certificate" "certificate" {
    provider = aws.east-1
    domain_name = local.root_domain_str
    validation_method = "DNS"

    subject_alternative_names = [
        local.all_subdomains_str,
        local.root_domain_str,
    ]
}

# Route 53 Record for aorlowski.com to utilize certificate for HTTPS
resource "aws_route53_record" "certificate_record" {
    for_each = {
        for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
            name = dvo.resource_record_name
            record = dvo.resource_record_value
            type = dvo.resource_record_type
        }
    }
    zone_id = local.hosted_zone_id

    allow_overwrite = true
    name = each.value.name
    records = [each.value.record]
    ttl = 60
    type = each.value.type
}

# Validate ACM Certificate with Route53
resource "aws_acm_certificate_validation" "certificate_validation" {
    provider = aws.east-1
    certificate_arn = aws_acm_certificate.certificate.arn
    validation_record_fqdns = [for record in aws_route53_record.certificate_record : record.fqdn]
}

# END CERTIFICATE FOR *aorlowski.com
# END CERTIFICATE FOR *aorlowski.com

# START DYNAMODB FOR VIEWER COUNT
# START DYNAMODB FOR VIEWER COUNT
resource "aws_dynamodb_table" "dynamodb_statistics_table" {
    name = "aorlowski-visitors"
    provider = aws.east-1

    billing_mode = "PAY_PER_REQUEST"
    hash_key = "statistic"

    read_capacity = 0
    write_capacity = 0
    stream_enabled = false
    table_class = "STANDARD_INFREQUENT_ACCESS"

    attribute {
      name = "statistic"
      type = "S"
    }

    point_in_time_recovery {
      enabled = false
    }

    timeouts {}

    lifecycle {
      ignore_changes = [
        write_capacity,
        read_capacity
      ]
    }
}

# INSERT viewer_count STATISTIC
resource "aws_dynamodb_table_item" "viewer_count_statistic" {
    provider = aws.east-1
    table_name = aws_dynamodb_table.dynamodb_statistics_table.name
    hash_key = aws_dynamodb_table.dynamodb_statistics_table.hash_key

    item = <<ITEM
    {
        "statistic": {"S": "view-count"},
        "Quantity": {"N": "0"}
    }
    ITEM
}

# END DYNAMODB FOR VIEWER COUNT
# END DYNAMODB FOR VIEWER COUNT

# START API GATEWAY
resource "aws_api_gateway_rest_api" "aorlowski_rest_api" {
    name = "aorlowski-rest-api"
    description = "A REST API for everything backend-related to aorlowski.com"
    put_rest_api_mode = "overwrite"

    endpoint_configuration {
      types = [
          "REGIONAL"
      ]
    }
}

# Start getAndIncrement endpoint
resource "aws_api_gateway_resource" "aorlowski_visitor_getAndIncrement_resource" {
    parent_id = aws_api_gateway_rest_api.aorlowski_rest_api.root_resource_id
    path_part = "viewerCount_getAndIncrement"
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
}

# POST on /viewerCount_getAndIncrement
resource "aws_api_gateway_method" "aorlowski_visitor_getAndIncrement_method" {
    authorization = "NONE"
    http_method = "POST"
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
}

resource "aws_api_gateway_integration" "aorlowski_visitor_getAndIncrement_integration" {
    http_method = aws_api_gateway_method.aorlowski_visitor_getAndIncrement_method.http_method
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    type = "AWS_PROXY"
    integration_http_method = "POST"
    uri = aws_lambda_function.aorlowski_getAndIncrement_lambda.invoke_arn
}
# End getAndIncrement endpoint

# Add option for GET only which won't increment
resource "aws_api_gateway_method" "aorlowski_visitor_get_method" {
    authorization = "NONE"
    http_method = "GET"
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
}

resource "aws_api_gateway_integration" "aorlowski_visitor_get_integration" {
    http_method = aws_api_gateway_method.aorlowski_visitor_get_method.http_method
    resource_id = aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    type = "AWS_PROXY"
    integration_http_method = "POST"
    uri = aws_lambda_function.aorlowski_getAndIncrement_lambda.invoke_arn
}
# End option for GET only which won't increment

resource "aws_api_gateway_deployment" "aorlowski_rest_api_deployment" {
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

resource "aws_api_gateway_stage" "aorlowski_production_stage" {
    deployment_id = aws_api_gateway_deployment.aorlowski_rest_api_deployment.id
    rest_api_id = aws_api_gateway_rest_api.aorlowski_rest_api.id
    stage_name = "aorlowski_production"
} 
# END API GATEWAY

# START LAMBDA FOR PROCESSING getAndIncrement FROM API GATEWAY
data "archive_file" "zip_aorlowski_lambda" {
    type = "zip"
    # TODO: Replace hardcoded paths with variables
    source_file = "../backend/aorlowski_lambda/lambda.py"
    output_path = "../backend/aorlowski_lambda/lambda.zip"
}

resource "aws_lambda_function" "aorlowski_getAndIncrement_lambda" {
    filename      = data.archive_file.zip_aorlowski_lambda.output_path
    function_name = "aorlowski-get-viewer-count-and-increment"
    role          = aws_iam_role.aorlowski_getAndIncrement_lambda_role.arn
    handler       = "lambda.lambda_handler"
    runtime       = "python3.9"

    # TODO: Replace hardcoded paths with variables
    source_code_hash = filebase64sha256("../backend/aorlowski_lambda/lambda.py")
}

# ROLE FOR LAMBDA
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
        "Resource": "arn:aws:logs:*:*:*"
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

# LAMBDA PERMISSION TO BE EXECUTED FROM API GATEWAY POST
resource "aws_lambda_permission" "apigw_lambda_post" {
    statement_id  = "AllowExecutionFromAPIGatewayPost"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.aorlowski_getAndIncrement_lambda.function_name
    principal     = "apigateway.amazonaws.com"

    # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
    source_arn = "arn:aws:execute-api:us-east-2:${var.accountId}:${aws_api_gateway_rest_api.aorlowski_rest_api.id}/*/${aws_api_gateway_method.aorlowski_visitor_getAndIncrement_method.http_method}${aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.path}"
}

# LAMBDA PERMISSION TO BE EXECUTED FROM API GATEWAY GET
resource "aws_lambda_permission" "apigw_lambda_get" {
    statement_id  = "AllowExecutionFromAPIGatewayGet"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.aorlowski_getAndIncrement_lambda.function_name
    principal     = "apigateway.amazonaws.com"

    # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
    source_arn = "arn:aws:execute-api:us-east-2:${var.accountId}:${aws_api_gateway_rest_api.aorlowski_rest_api.id}/*/${aws_api_gateway_method.aorlowski_visitor_get_method.http_method}${aws_api_gateway_resource.aorlowski_visitor_getAndIncrement_resource.path}"
}

# END LAMBDA FOR PROCESSING getAndIncrement FROM API GATEWAY