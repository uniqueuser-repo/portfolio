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

# START ROOT DOMAIN BUCKET
# START ROOT DOMAIN BUCKET
resource "aws_s3_bucket" "root-domain" {
    bucket = "aorlowski.com"
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

    lifecycle {
      prevent_destroy = true
    }
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

resource "aws_s3_bucket_object" "upload_build" {
    for_each = fileset("/mnt/c/Users/Andy/Desktop/portfolio/build/", "**")

    bucket = aws_s3_bucket.root-domain.bucket
    key = each.value
    source = "/mnt/c/Users/Andy/Desktop/portfolio/build/${each.value}"

    etag = filemd5("/mnt/c/Users/Andy/Desktop/portfolio/build/${each.value}")
}
# END ROOT DOMAIN BUCKET
# END ROOT DOMAIN BUCKET


# START SUBDOMAIN (WWW.) BUCKET
# START SUBDOMAIN (WWW.) BUCKET
resource "aws_s3_bucket" "subdomain-www" {
    bucket = "www.aorlowski.com"
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

    lifecycle {
      prevent_destroy = true
    }
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
      host_name = "www.aorlowski.com"
      protocol = "http"
    }
}
# END SUBDOMAIN (WWW.) BUCKET
# END SUBDOMAIN (WWW.) BUCKET