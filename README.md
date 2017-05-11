# Terraform AWS Elastic Beanstalk NodeJS

Terraform script to setup AWS Elastic Beanstalk with a load-balanced NodeJS app

## What this script does

* Create an Elastic Beanstalk Application and environment.
* Setup the EB environment with NodeJS, an Elastic Loadbalancer and forward port from HTTP / HTTPS to the specified instance port.
* It is also able to create a Route53 Alias to link your domain to the EB domain name


## Usage

Create a `main.tf` file with the following configuration:

### to create an EB environment

```hcl
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
  min_instance = "2"
  max_instance = "4"

  # ELB
  enable_https = "false" # If set to true, you will need to add an ssl_certificate_id (see L70 in app/variables.tf)

  # Security
  vpc_id = "vpc-xxxxxxx"
  vpc_subnets = "subnet-xxxxxxx"
  elb_subnets = "subnet-xxxxxxx"
  security_groups = "sg-xxxxxxx"
}
```

### to link your domain using Route53

Add to the previous script the following lines:

```hcl
##################################################
## Route53 config
##################################################
module "app_dns" {
  source = "github.com/BasileTrujillo/terraform-elastic-beanstalk-nodejs//r53-alias"
  aws_region = "${var.aws_region}"

  domain = "example.io"
  domain_name = "my-app.example.io"
  eb_cname = "${module.app.eb_cname}"
}
``` 

### Example

Take a look at [example.tf](./example.tf) for a full example.

## Customize

Many options are available through variables. Feel free to look into `app/variables.tf` to see all parameters you can setup.
