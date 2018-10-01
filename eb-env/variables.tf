##################################################
## App Variables
##################################################
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
  description = "The AWS Region"
}

variable "aws_profile" {
  type    = "string"
  default = "default"
  description = "The AWS Profile credentials profile"
}

# Application
variable "service_name" {
  type    = "string"
  description = "The application name"
}
variable "service_description" {
  type    = "string"
  default = ""
  description = "The application description"
}
variable "env" {
  type    = "string"
  default = "dev"
  description = "The environment (dev, stage, prod)"
}

# Instance
variable "eb_solution_stack_name" {
  type    = "string"
  default = "64bit Amazon Linux 2016.09 v4.0.1 running Node.js"
  description = "The Elastic Beanstalk solution stack name"
}
variable "instance_type" {
  type    = "string"
  default = "t2.small"
  description = "The EC2 instance type"
}
variable "ssh_key_name" {
  type    = "string"
  default = "Ireland_VPC"
  description = "The EC2 SSH KeyPair Name"
}
variable "public_ip" {
  type = "string"
  default = "false"
  description = "EC2 instances must have a public ip (true | false)"
}
variable "min_instance" {
  type    = "string"
  default = "1"
  description = "The minimum number of instances"
}
variable "max_instance" {
  type    = "string"
  default = "1"
  description = "The maximum number of instances"
}
variable "deployment_policy" {
  type    = "string"
  default = "Rolling"
  description = "The deployment policy"
  # https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html?icmpid=docs_elasticbeanstalk_console
}

# Load Balancing
variable "port" {
  type    = "string"
  default = "3000"
  description = "The instance port"
}
variable "ssl_certificate_id" {
  type    = "string"
  default = ""
  description = "ARN of an SSL certificate to bind to the listener."
}
variable "healthcheck_url" {
  type    = "string"
  default = "HTTP:3000/healthcheck"
  description = "The path to which to send health check requests."
}
variable "ignore_healthcheck" {
  type    = "string"
  default = "true"
  description = "Do not cancel a deployment due to failed health checks. (true | false)"
}
variable "enable_http" {
  type = "string"
  default = "true"
  description = "Enable or disable default HTTP connection on port 80."
}
variable "enable_https" {
  type = "string"
  default = "true"
  description = "Enable or disable HTTPS connection on port 443."
}
variable "elb_connection_timeout" {
  type = "string"
  default = "60"
  description = "Number of seconds that the load balancer waits for any data to be sent or received over the connection."
}


# NodeJS
# https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-specific.html#command-options-nodejs
variable "node_cmd" {
  type    = "string"
  default = ""
  description = "Command used to start the Node.js application."
}
variable "node_version" {
  type    = "string"
  default = "8.1.4"
  description = "Version of Node.js."
}
variable "proxy_server" {
  type    = "string"
  default = "none"
  description = "Specifies which web server should be used to proxy connections to Node.js."
}

variable "xray_enable" {
  type    = "string"
  default = "true"
}

# Security
variable "vpc_id" {
  type    = "string"
  description = "The ID for your VPC."
}
variable "vpc_subnets" {
  type    = "string"
  description = "The IDs of the Auto Scaling group subnet or subnets."
}
variable "elb_subnets" {
  type    = "string"
  description = "The IDs of the subnet or subnets for the elastic load balancer."
}
variable "security_groups" {
  type    = "string"
  default = "elasticbeanstalk-default"
  description = "Lists the Amazon EC2 security groups to assign to the EC2 instances in the Auto Scaling group in order to define firewall rules for the instances."
}

# Elastic File Storage (Environment variables)
variable "efs_id" {
  type    = "string"
  default = ""
  description = "The EFS ID to put in an EB Environment variable called EFS_ID."
}
variable "efs_mount_directory" {
  type    = "string"
  default = ""
  description = "The EFS Mount Directory to put in an EB Environment variable called EFS_MOUNT_DIRECTORY."
}
