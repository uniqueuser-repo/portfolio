terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
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