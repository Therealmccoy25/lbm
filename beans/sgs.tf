# Define common tags to be applied to all security gorups
locals {
  common_tags = {
    CostCenter  = "${var.costcenter}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "alb" {
  name_prefix = "${var.app_name}-${var.environment}-alb"
  vpc_id      = "${var.vpc_id}"
  tags = "${merge(local.common_tags, map("Name","${var.app_name}-${var.environment}-alb"))}"
}

resource "aws_security_group" "app" {
  name_prefix = "${var.app_name}-${var.environment}-app"
  vpc_id      = "${var.vpc_id}"
  tags = "${merge(local.common_tags, map("Name","${var.app_name}-${var.environment}-app"))}"
}

resource "aws_security_group_rule" "alb-to-app" {
  type = "ingress"

  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"

  source_security_group_id = "${aws_security_group.alb.id}"

  security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group_rule" "egress-alb-to-app" {
  type = "ingress"

  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"

  source_security_group_id = "${var.vpn_sg}"

  security_group_id = "${aws_security_group.alb.id}"
}

resource "aws_security_group_rule" "vpn-to-alb" {
  type = "egress"

  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"

  source_security_group_id = "${aws_security_group.app.id}"

  security_group_id = "${aws_security_group.alb.id}"
}