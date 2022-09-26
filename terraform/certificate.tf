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

# Validate ACM Certificate with Route53
resource "aws_acm_certificate_validation" "certificate_validation" {
    provider = aws.east-1
    certificate_arn = aws_acm_certificate.certificate.arn
    validation_record_fqdns = [for record in aws_route53_record.certificate_record : record.fqdn]
}

# END CERTIFICATE FOR *aorlowski.com
# END CERTIFICATE FOR *aorlowski.com