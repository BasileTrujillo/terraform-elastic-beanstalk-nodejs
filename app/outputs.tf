##################################################
## App Variables Output
##################################################
output "eb_cname" {
  value = "${aws_elastic_beanstalk_environment.eb_env.cname}"
}
