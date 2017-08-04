##################################################
## Your variables
##################################################
variable "aws_region" {
  type        = "string"
  description = "The AWS Region"
  default     = "eu-west-1"
}
variable "service_name" {
  type    = "string"
  default = "nodejs-app-test"
}
variable "service_description" {
  type    = "string"
  default = "My awesome nodeJs App"
}
variable "env" {
  type    = "string"
  default = "dev"
}
variable "domain_name" {
  type    = "string"
  default = "app-test.example.io"
}

##################################################
## AWS
##################################################
provider "aws" {
  region = "${var.aws_region}"
}

##################################################
## Elastic Beanstalk
##################################################
resource "aws_elastic_beanstalk_application" "eb_app" {
  name        = "${var.service_name}"
  description = "${var.service_description}"
}

module "app" {
  source      = "github.com/BasileTrujillo/terraform-elastic-beanstalk-nodejs//eb-env"
  aws_region  = "${var.aws_region}"

  # Application settings
  service_name          = "${var.service_name}"
  service_description   = "${var.service_description}"
  env                   = "${var.env}"

  # Instance settings
  instance_type = "t2.micro"
  min_instance  = "1"
  max_instance  = "1"

  # ELB
  enable_https            = "false"
  elb_connection_timeout  = "120"

  # Security
  vpc_id            = "vpc-xxxxxxx"
  vpc_subnets       = "subnet-xxxxxxx"
  elb_subnets       = "subnet-xxxxxxx"
  security_groups   = "sg-xxxxxxx"
}

##################################################
## CloudFront
##################################################
module "app_cdn" {
  source              = "github.com/BasileTrujillo/terraform-elastic-beanstalk-nodejs//cloudfront"

  service_name        = "${var.service_name}"
  env                 = "${var.env}"
  origin_domain_name  = "${module.app.eb_cname}"
  domain_name         = "${var.domain_name}"
}

##################################################
## Route53
##################################################
module "app_dns" {
  source      = "github.com/BasileTrujillo/terraform-elastic-beanstalk-nodejs//r53-alias"
  aws_region  = "${var.aws_region}"

  domain              = "example.io"
  domain_name         = "${var.domain_name}"
  eb_cname            = "${module.app_cdn.cf_cname}"
  eb_route53_zone_id  = "${module.app_cdn.cf_hosted_zone_id}"
}
