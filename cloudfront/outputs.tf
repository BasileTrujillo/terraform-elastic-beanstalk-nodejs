##################################################
## App Variables Output
##################################################
output "cf_cname" {
  value = "${aws_cloudfront_distribution.app_cdn.domain_name}"
}
output "cf_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.app_cdn.hosted_zone_id}"
}
