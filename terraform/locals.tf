locals {
    root_domain_str = "aorlowski.com"
    subdomain_str = "www.aorlowski.com"
    all_subdomains_str = "*.aorlowski.com"

    # When we upload the build to S3, we need to make sure each individual Object uploaded has the correct content-type associated.
    # If not specified, all files are uploaded as "application/octet-stream", which is definitely wrong and will cause problems.
    # We can use a dictionary (seen below) to look up the content type of a file as we process each of them in the aws_s3_bucket_object.upload_build resource.
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
    "woff2" = "font/woff2"
    "eot" = "application/vnd.ms"
    }

    build_dir = "../build/"

    # I don't want Terraform to manage the hosted zone, so I will leave it hardcoded.
    hosted_zone_id = "Z02236511VLB1LAPEVX01"

    path_to_backend = "../backend/aorlowski_lambda/"
}