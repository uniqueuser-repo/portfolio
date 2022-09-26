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