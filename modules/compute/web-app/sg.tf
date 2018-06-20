resource "aws_security_group" "web" {
  name        = "${var.project}-web-sg"
  description = "${var.project} web security group"

  vpc_id = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name","sg-web-${var.project}"))}"
}

data "aws_security_group" "bastion" {
  name = "${var.sg_bastion}"
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = "${aws_security_group.web.id}"

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${data.aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "allow_http" {
  security_group_id = "${aws_security_group.web.id}"

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.alb.id}"
}

resource "aws_security_group_rule" "allow_net" {
  security_group_id = "${aws_security_group.web.id}"

  type        = "egress"
  from_port   = -1
  to_port     = -1
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "alb" {
  name        = "${var.project}-alb-sg"
  description = "${var.project} loadbalancer security group"

  vpc_id = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name","sg-alb-${var.project}"))}"
}

resource "aws_security_group_rule" "allow_ssh_alb" {
  security_group_id = "${aws_security_group.alb.id}"

  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_net_alb" {
  security_group_id = "${aws_security_group.alb.id}"

  type        = "egress"
  from_port   = -1
  to_port     = -1
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}
