# START CLOUDFRONT DISTRIBUTION FOR old.aorlowski.com
resource "aws_cloudfront_distribution" "aorlowski_s3_distribution" {
    origin {
        domain_name = aws_s3_bucket.old-aorlowski-domain.bucket_regional_domain_name
        origin_id = aws_s3_bucket.old-aorlowski-domain.bucket_regional_domain_name
        connection_attempts = 3
        connection_timeout = 10
    }

    enabled = true
    is_ipv6_enabled = true
    default_root_object = "index.html"

    aliases = [
        local.old_domain_str
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

      target_origin_id = aws_s3_bucket.old-aorlowski-domain.bucket_regional_domain_name
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

    custom_error_response {
      error_caching_min_ttl = 60
      error_code = 403
      response_code = 200
      response_page_path = "/index.html"
    }
}
# END CLOUDFRONT DISTRIBUTION FOR old.aorlowski.com

# START CLOUDFRONT DISTRIBUTION FOR images.aorlowski.com
resource "aws_cloudfront_distribution" "images_s3_distribution" {
    origin {
      domain_name = aws_s3_bucket.images-aorlowski-com-bucket.bucket_regional_domain_name
      origin_id = aws_s3_bucket.images-aorlowski-com-bucket.bucket_regional_domain_name
      connection_attempts = 3
      connection_timeout = 10
      
      s3_origin_config {
        origin_access_identity = "${aws_cloudfront_origin_access_identity.oai_for_image_aorlowski_com.cloudfront_access_identity_path}"
      }
        
    }

    enabled = true
    is_ipv6_enabled = true

    aliases = [
        local.images_domain_str
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

      target_origin_id = aws_s3_bucket.images-aorlowski-com-bucket.bucket_regional_domain_name
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

resource "aws_cloudfront_origin_access_identity" "oai_for_image_aorlowski_com" {
  comment = "OAI for images.aorlowski.com"
}
# END CLOUDFRONT DISTRIBUTION FOR images.aorlowski.com