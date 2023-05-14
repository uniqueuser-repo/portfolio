# START old.aorlowski.com BUCKET
# START old.aorlowski.com BUCKET
resource "aws_s3_bucket" "old-aorlowski-domain" {
    bucket = local.old_domain_str
    force_destroy = true
}

resource "aws_s3_bucket_policy" "old-aorlowski-domain-policy" {
  bucket = aws_s3_bucket.old-aorlowski-domain.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.old-aorlowski-domain.id}/*"
    }
  ]
}
EOF

    depends_on = [ aws_s3_bucket_public_access_block.public_old_aorlowski_bucket ]
}

resource "aws_s3_bucket_public_access_block" "public_old_aorlowski_bucket" {
  bucket = aws_s3_bucket.old-aorlowski-domain.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "old-domain-bucket-website-config" {
    bucket = aws_s3_bucket.old-aorlowski-domain.bucket

    index_document {
      suffix = "index.html"
    }
}

resource "aws_s3_bucket_object" "upload_build" {
    for_each = fileset(local.build_dir, "**")

    bucket = aws_s3_bucket.old-aorlowski-domain.bucket
    key = each.value
    source = "${local.build_dir}${each.value}"

    # Determine the content type by getting the extension of the file and searching dor it in the map
    content_type = lookup(tomap(local.mime_types), element(split(".", each.value), length(split(".", each.value)) - 1))

    etag = filemd5("${local.build_dir}${each.value}")
}
# END old.aorlowski.com BUCKET
# END old.aorlowski.com BUCKET