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

    logging_config {
        include_cookies = false
        bucket = aws_s3_bucket.aorlowski_cloudwatch.bucket_domain_name
        prefix = "aorlowski"
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