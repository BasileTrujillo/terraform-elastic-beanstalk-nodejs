##################################################
## Your variables
##################################################
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
}

##################################################
## AWS config
##################################################
provider "aws" {
  region = "${var.aws_region}"
}

##################################################
## Elastic Beanstalk config
##################################################
module "app" {
  source = "github.com/BasileTrujillo/terraform-elastic-beanstalk-nodejs//app"
  aws_region = "${var.aws_region}"

  # Application settings
  service_name = "nodejs-app-test"
  service_description = "My awesome nodeJs App"
  env = "dev"

  # Instance settings
  instance_type = "t2.micro"
  min_instance = "1"
  max_instance = "1"

  # ELB
  enable_https = "false"

  # Security
  vpc_id = "vpc-827f5ee6"
  vpc_subnets = "subnet-b9ac9ddd"
  elb_subnets = "subnet-d34370b7"
  security_groups = "sg-2885d24e"
}

##################################################
## Route53 config
##################################################
module "app_dns" {
  source = "github.com/BasileTrujillo/terraform-elastic-beanstalk-nodejs//r53-alias"
  aws_region = "${var.aws_region}"

  domain = "exaprint.io"
  domain_name = "app-test.exaprint.io"
  eb_cname = "${module.app.eb_cname}"
}
