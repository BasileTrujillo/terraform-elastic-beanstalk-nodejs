##################################################
## Your variables
##################################################
variable "aws_region" {
  type        = "string"
  description = "The AWS Region"
  default     = "eu-west-1"
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
  elb_connection_timeout = "120"

  # Security
  vpc_id = "vpc-xxxxxxx"
  vpc_subnets = "subnet-xxxxxxx"
  elb_subnets = "subnet-xxxxxxx"
  security_groups = "sg-xxxxxxx"
}

##################################################
## Route53 config
##################################################
module "app_dns" {
  source = "github.com/BasileTrujillo/terraform-elastic-beanstalk-nodejs//r53-alias"
  aws_region = "${var.aws_region}"

  domain = "example.io"
  domain_name = "app-test.example.io"
  eb_cname = "${module.app.eb_cname}"
}
