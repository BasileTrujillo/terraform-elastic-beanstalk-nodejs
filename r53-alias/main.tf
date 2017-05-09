##################################################
## Route53 Link to cloudfront (API Gateway Domain)
##################################################
data "aws_route53_zone" "dns_zone" {
  name = "${var.domain}."
}

resource "aws_route53_record" "dns_record" {
  zone_id = "${data.aws_route53_zone.dns_zone.id}"

  name = "${var.domain_name}"
  type = "A"

  alias {
    name                   = "${var.eb_cname}"
    zone_id                = "${var.eb_route53_zone_id}"
    evaluate_target_health = true
  }
}
