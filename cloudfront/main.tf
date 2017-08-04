##################################################
## AWS config
##################################################
provider "aws" {
  region = "${var.aws_region}"
}

##################################################
## S3 Bucket for CloudFront Logs
##################################################
resource "aws_s3_bucket" "cf_log_bucket" {
  region = "${var.aws_region}"
  bucket = "${var.env}-${var.service_name}-cf-logs"
  acl    = "log-delivery-write"

  lifecycle_rule {
    id      = "log-rotation"
    prefix  = "${var.log_prefix}"
    enabled = "${var.log_lifecycle_rule_enabled}"

    transition {
      days          = "${var.log_standard_ia_retention_days}"
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = "${var.log_glacier_retention_days}"
      storage_class = "GLACIER"
    }

    expiration {
      days = "${var.log_expiration_days}"
    }
  }
}

##################################################
## Cloudfront distribution
##################################################
resource "aws_cloudfront_distribution" "app_cdn" {
  origin {
    domain_name = "${var.origin_domain_name}"
    origin_id   = "${var.env}-${var.service_name}"

    custom_origin_config {
      http_port = "${var.custom_origin_http_port}"
      https_port = "${var.custom_origin_https_port}"
      origin_protocol_policy = "${var.custom_origin_protocol_policy}"
      origin_ssl_protocols = "${var.custom_origin_ssl_protocols}"
    }
  }

  aliases             = ["${var.domain_name}"]
  enabled             = "${var.enabled}"
  is_ipv6_enabled     = "${var.is_ipv6_enabled}"
  comment             = "${var.service_name} (${var.env})"

  logging_config {
    include_cookies = "${var.log_include_cookies}"
    bucket          = "${aws_s3_bucket.cf_log_bucket.bucket_domain_name}"
    prefix          = "${var.log_prefix}"
  }

  default_cache_behavior {
    allowed_methods  = "${var.cache_allowed_methods}"
    cached_methods   = "${var.cached_methods}"
    target_origin_id = "${var.env}-${var.service_name}"
    compress = "${var.cache_compress}"

    forwarded_values {
      query_string = "${var.cache_forward_query_string}"

      cookies {
        forward = "${var.cache_forward_cookies}"
      }
    }

    viewer_protocol_policy = "${var.cache_viewer_protocol_policy}"
    min_ttl                = "${var.cache_min_ttl}"
    default_ttl            = "${var.cache_default_ttl}"
    max_ttl                = "${var.cache_max_ttl}"
  }

  # https://aws.amazon.com/fr/cloudfront/pricing/
  price_class = "${var.price_class}"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "FR", "GB", "DE"]
    }
  }

  tags {
    Name = "${var.env}-${var.service_name}"
    Environment = "${var.env}"
  }

  viewer_certificate {
    cloudfront_default_certificate = "${var.cloudfront_default_certificate}"
    acm_certificate_arn = "${var.ssl_certificate_id}"
    ssl_support_method = "${var.ssl_support_method}"
    minimum_protocol_version = "TLSv1"
  }
}
