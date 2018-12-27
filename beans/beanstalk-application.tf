resource "aws_elastic_beanstalk_application" "demo" {
  name = "${var.app_name}-${var.environment}"
}

resource "aws_elastic_beanstalk_configuration_template" "demo" {
  name  = "${var.app_name}-${var.environment}"
  application = "${aws_elastic_beanstalk_application.demo.name}"
  solution_stack_name = "${data.aws_elastic_beanstalk_solution_stack.default.name}"
}

resource "aws_elastic_beanstalk_application_version" "demo" {
	name = "${var.app_zip}"
	application = "${aws_elastic_beanstalk_application.demo.name}"
	description = "Glyphic application version created by Terraform"
	bucket = "${var.app_bucket}"
	key = "${var.app_zip}"
}