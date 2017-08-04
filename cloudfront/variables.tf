##################################################
## App Variables
##################################################
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
  description = "The AWS Region"
}

# Application
variable "service_name" {
  type    = "string"
  description = "The application name"
}
variable "env" {
  type    = "string"
  default = "dev"
  description = "The environment (dev, stage, prod)"
}
variable "enabled" {
  type    = "string"
  default = "true"
  description = "Enable or disable cloudfront distribution."
}
variable "is_ipv6_enabled" {
  type    = "string"
  default = "true"
  description = "Enable or disable IPv6"
}

## Cloudfront settings
variable "domain_name" {
  type    = "string"
  description = "Final Domain name associated to cloudfront"
}
variable "origin_domain_name" {
  type    = "string"
  description = "Origin Domain name (in our case, the EB CNAME)"
}
variable "custom_origin_http_port" {
  type    = "string"
  default = "80"
  description = "Custom Origin HTTP Port"
}
variable "custom_origin_https_port" {
  type    = "string"
  default = "443"
  description = "Custom Origin HTTPS Port"
}
variable "custom_origin_protocol_policy" {
  type    = "string"
  default = "http-only"
  description = "Terminaison between cloudfront and the origin. One of http-only, https-only, or match-viewer."
}
variable "custom_origin_ssl_protocols" {
  type    = "list"
  default = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
  description = "The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2."
}
variable "price_class" {
  type    = "string"
  default = "PriceClass_100"
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
}


## Log settings
variable "log_prefix" {
  type    = "string"
  default = "log/"
  description = "S3 Bucket Prefix for loging"
}
variable "log_lifecycle_rule_enabled" {
  type    = "string"
  default = "true"
  description = "Enable or disable lifecycle rule for log bucket"
}
variable "log_standard_ia_retention_days" {
  type    = "string"
  default = "30"
  description = "Log lifecycle rule for Standard IA Retention days"
}
variable "log_glacier_retention_days" {
  type    = "string"
  default = "60"
  description = "Log lifecycle rule for Glacier Retention days"
}
variable "log_expiration_days" {
  type    = "string"
  default = "90"
  description = "Log lifecycle rule for expiration days"
}
variable "log_include_cookies" {
  type    = "string"
  default = "false"
  description = "Enable or disable cookie loging"
}

# Default Cache Behavior
variable "cache_allowed_methods" {
  type    = "list"
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
}
variable "cached_methods" {
  type    = "list"
  default = ["GET", "HEAD"]
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
}
variable "cache_compress" {
  type    = "string"
  default = "true"
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)."
}
variable "cache_forward_query_string" {
  type    = "string"
  default = "true"
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
}
variable "cache_forward_cookies" {
  type    = "string"
  default = "all"
  description = "Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names"
}
variable "cache_viewer_protocol_policy" {
  type    = "string"
  default = "redirect-to-https"
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
}
variable "cache_min_ttl" {
  type    = "string"
  default = "0"
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
}
variable "cache_max_ttl" {
  type    = "string"
  default = "86400" # 24h
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers."
}
variable "cache_default_ttl" {
  type    = "string"
  default = "3600" # 1h
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header."
}

# Geo Restrictions
variable "geo_restriction_type" {
  type = "string"
  default = "whitelist"
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
}
variable "geo_restriction_locations" {
  type = "list"
  default = ["US", "FR", "GB", "DE"] # http://www.iso.org/iso/country_codes/iso_3166_code_lists/country_names_and_code_elements.htm
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
}

# SSL settings
variable "cloudfront_default_certificate" {
  type = "string"
  default = "true"
  description = "true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution. Specify this, acm_certificate_arn, or iam_certificate_id."
}
variable "ssl_support_method" {
  type = "string"
  default = "sni-only"
  description = "Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges."
}
variable "ssl_certificate_id" {
  type    = "string"
  default = ""
  description = "ARN of an SSL certificate to bind to the listener."
}
variable "minimum_protocol_version" {
  type    = "string"
  default = "TLSv1"
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. One of SSLv3 or TLSv1. Default: SSLv3. NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), and have specified sni-only in ssl_support_method, TLSv1 must be specified."
}