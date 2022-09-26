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

    force_destroy = true

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

    force_destroy = true
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

# START CLOUDFRONT LOGS BUCKET
# START CLOUDFRONT LOGS BUCKET
resource "aws_s3_bucket" "aorlowski_cloudwatch" {
    bucket = "aorlowski-cloudwatch"

    force_destroy = true
}
# END CLOUDFRONT LOGS BUCKET
# END CLOUDFRONT LOGS BUCKET