variable "app_name" {
	description = "The name of the elastic beanstalk application"
}

variable "environment" {
	description = "The name of the environment to create within the elastic beanstalk application(i.e. dev or uat)"
}

variable "instance_type" {}

variable "instance_profile" {
  description = "The IAM instance profile to attach to the elastic beanstalk application environment"
}

variable "iam_service_role" {
  description = "The IAM service role used by the elastic beanstalk environment"
  default = "aws-elasticbeanstalk-service-role"
}

variable "vpc_id" {
  description = "VPC Id to create the beanstalk environment in"
}

variable "subnets" {
  type = "list"
  description = "Array of subnet IDs for beanstalk environnment"
}

variable "key_pair_name" {
  description = "SSH keypair for beanstalk environment"
}

variable "costcenter" {
  description = "Value to assign to the costcenter tag"
  default = ""
}

variable "app_bucket" {
  description = "S3 bucket that the application code is stored in"
}

variable "app_zip" {
  description = "Filename of the zip file in the S3 bucket. Include any folders in the path as needed."
}

variable "vpn_sg" {
  description = "security group ID of the openvpn security group"
}
