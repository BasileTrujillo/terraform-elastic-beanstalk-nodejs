##################################################
## Route53 Variables
##################################################
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
  description = "The AWS Region"
}
variable "domain" {
  type    = "string"
  description = "The Route53 Hosted Zone domain name without final dot (ex: example.io)"
}
variable "domain_name" {
  type    = "string"
  description = "The record set domain name (ex: app.example.io)"
}
variable "eb_route53_zone_id" {
  type    = "string"
  default = "Z2NYPWQ7DFZAZH" # --> eu-west-1
  description = "The Elastic Beanstalk Route53 Zone ID (related to the doc)"
  # http://docs.aws.amazon.com/general/latest/gr/rande.html#elasticbeanstalk_region
}
variable "eb_cname" {
  type    = "string"
  description = "The Elastic Beanstalk CNAME"
}
