resource "aws_elastic_beanstalk_environment" "default" {
  name = "${var.app_name}-${var.environment}"
  description = "${var.app_name}-${var.environment}"
  application = "${aws_elastic_beanstalk_application.demo.name}"
  template_name = "${aws_elastic_beanstalk_configuration_template.demo.name}"
  version_label = "${aws_elastic_beanstalk_application_version.demo.name}"
  tags {
    CostCenter = "${var.costcenter}"
    Environment = "${var.environment}"
    Application = "${var.app_name}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = "${var.vpc_id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = "${join(",",var.subnets)}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = "${join(",",var.subnets)}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "internal"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "Cooldown"
    value = "300"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "${var.instance_profile}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "EC2KeyName"
    value = "${var.key_pair_name}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "${var.instance_type}"
  }
  setting {
    namespace = "aws:elbv2:listener:default"
    name = "Rules"
    value = "default"
  }
  setting {
    namespace = "aws:elbv2:listenerrule:default"
    name = "PathPatterns"
    value = "/*"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "EnvironmentType"
    value = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "LoadBalancerType"
    value = "application"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "${var.iam_service_role}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.app.id}"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "SecurityGroups"
    value = "${aws_security_group.alb.id}"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "ManagedSecurityGroup"
    value = "${aws_security_group.alb.id}"
  }
}