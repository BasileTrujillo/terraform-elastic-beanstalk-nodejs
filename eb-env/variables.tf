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
  default = "64bit Amazon Linux 2018.03 v4.8.1 running Node.js"
  description = "The Elastic Beanstalk solution stack name"
}
variable "instance_type" {
  type    = "string"
  default = "t3.small"
  description = "The EC2 instance type"
}
variable "instance_volume_type" {
  type    = "string"
  default = "gp2"
  description = "Volume type (magnetic, general purpose SSD or provisioned IOPS SSD) to use for the root Amazon EBS volume attached to your environment's EC2 instances."
  # standard for magnetic storage
  # gp2 for general purpose SSD
  # io1 for provisioned IOPS SSD
}
variable "instance_volume_size" {
  type    = "string"
  default = "10"
  description = "Storage capacity of the root Amazon EBS volume in whole GB. Required if you set RootVolumeType to provisioned IOPS SSD."
  # 10 to 16384 GB for general purpose and provisioned IOPS SSD.
  # 8 to 1024 GB for magnetic.
}
variable "instance_volume_iops" {
  type    = "string"
  default = "100"
  description = "Desired input/output operations per second (IOPS) for a provisioned IOPS SSD root volume."
  # The maximum ratio of IOPS to volume size is 30 to 1. For example, a volume with 3000 IOPS must be at least 100 GB.
  # Value can be from 100 to 20000
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
variable "environmentType" {
  type    = "string"
  default = "LoadBalanced"
  description = "Set to SingleInstance to launch one EC2 instance with no load balancer."
}

# Load Balancing
variable "loadBalancerType" {
  type    = "string"
  default = "classic"
  description = "The type of load balancer for your environment. (classic, application, network)"
}
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
variable "healthcheck_healthy_threshold" {
  type    = "string"
  default = "3"
  description = "Consecutive successful requests before Elastic Load Balancing changes the instance health status."
}
variable "healthcheck_unhealthy_threshold" {
  type    = "string"
  default = "5"
  description = "Consecutive unsuccessful requests before Elastic Load Balancing changes the instance health status."
}
variable "healthcheck_interval" {
  type    = "string"
  default = "10"
  description = "The interval at which Elastic Load Balancing will check the health of your application's Amazon EC2 instances."
}
variable "healthcheck_timeout" {
  type    = "string"
  default = "5"
  description = "Number of seconds Elastic Load Balancing will wait for a response before it considers the instance nonresponsive."
}

variable "ignore_healthcheck" {
  type    = "string"
  default = "true"
  description = "Do not cancel a deployment due to failed health checks. (true | false)"
}
variable "healthreporting" {
  type    = "string"
  default = "basic"
  description = "Health reporting system (basic or enhanced). Enhanced health reporting requires a service role and a version 2 platform configuration."
}
variable "notification_topic_arn" {
  type    = "string"
  default = ""
  description = "Amazon Resource Name for the topic you subscribed to."
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

# Auto Scaling
variable "as_breach_duration" {
  type = "string"
  default = "5"
  description = "Amount of time, in minutes, a metric can be beyond its defined limit (as specified in the UpperThreshold and LowerThreshold) before the trigger fires."
}
variable "as_lower_breach_scale_increment" {
  type = "string"
  default = "-1"
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}
variable "as_lower_threshold" {
  type = "string"
  default = "2000000"
  description = "If the measurement falls below this number for the breach duration, a trigger is fired."
}
variable "as_measure_name" {
  type = "string"
  default = "NetworkOut"
  description = "Metric used for your Auto Scaling trigger."
}
variable "as_period" {
  type = "string"
  default = "5"
  description = "Specifies how frequently Amazon CloudWatch measures the metrics for your trigger."
}
variable "as_statistic" {
  type = "string"
  default = "Average"
  description = "Statistic the trigger should use, such as Average."
}
variable "as_unit" {
  type = "string"
  default = "Bytes"
  description = "Unit for the trigger measurement, such as Bytes."
}
variable "as_upper_breachs_scale_increment" {
  type = "string"
  default = "1"
  description = "How many Amazon EC2 instances to add when performing a scaling activity."
}
variable "as_upper_threshold" {
  type = "string"
  default = "6000000"
  description = "If the measurement is higher than this number for the breach duration, a trigger is fired."
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
  default = "10.15.1"
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
