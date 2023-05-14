# Start Route 53 Record for old.aorlowski.com to have an A Record to the old CloudFront distribution
resource "aws_route53_record" "old_aorlowski_cloudfront_record" {
    # I don't want Terraform to manage the hosted zone, so I will leave this hard coded.
    zone_id = local.hosted_zone_id
    name = local.old_domain_str
    type = "A"

    alias {
        name = aws_cloudfront_distribution.aorlowski_s3_distribution.domain_name
        zone_id = aws_cloudfront_distribution.aorlowski_s3_distribution.hosted_zone_id
        evaluate_target_health = false
    }

    allow_overwrite = true
}
# End Route 53 Record for old.aorlowski.com to have an A Record to the old CloudFront distribution

# Start Route 53 Record for aorlowski.com to have an A Record to Vercel
resource "aws_route53_record" "aorlowski_cloudfront_record" {
    zone_id = local.hosted_zone_id
    name = local.root_domain_str
    type = "A"
    
    ttl = 900

    records = [local.vercel_dns_ip_str]

    allow_overwrite = true
}
# End Route 53 Record for aorlowski.com to have an A Record to Vercel

# Start Route 53 Record for www.aorlowski.com to have an CName Record to Vercel
resource "aws_route53_record" "wwww_aorlowski_cloudfront_record" {
    # I don't want Terraform to manage the hosted zone, so I will leave this hard coded.
    zone_id = local.hosted_zone_id
    name = local.subdomain_str
    type = "CNAME"

    ttl = 900

    records = [local.vercel_domain_str]

    allow_overwrite = true
}
# End Route 53 Record for www.aorlowski.com to have an CNAME Record to Vercel

# Start Route 53 Record for aorlowski.com to utilize certificate for HTTPS
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
# End Route 53 Record for aorlowski.com to utilize certificate for HTTPS

# Start Route53 Record to allow API Gateway to use Custom Domain Name
resource "aws_route53_record" "api_gateway_record" {
  name    = aws_api_gateway_domain_name.gateway_domain_name_aorlowski.domain_name
  type    = "A"
  zone_id = local.hosted_zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_api_gateway_domain_name.gateway_domain_name_aorlowski.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.gateway_domain_name_aorlowski.regional_zone_id
  }
}
# Start Route53 Record to allow API Gateway to use Custom Domain Name