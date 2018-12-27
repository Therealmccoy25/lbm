data "aws_elastic_beanstalk_solution_stack" "default" {
  most_recent = true
  name_regex = "^64bit Amazon Linux (.*) running Tomcat 8.5 Java 8$"
}