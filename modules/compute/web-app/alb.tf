# Create a new load balancer
resource "aws_alb" "alb" {
  name            = "${var.project}-alb-web"
  internal        = false
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["${var.subnets}"]

  enable_deletion_protection = false

  tags = "${merge(var.tags, map("Name","alb-${var.project}"))}"
}

resource "aws_alb_target_group" "alb_target" {
  name     = "${var.project}-alb-target"
  port     = "80"
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"

   tags {
    Name = "alb-target-${var.project}"
  }
}

resource "aws_alb_target_group_attachment" "alb_target" {
  target_group_arn = "${aws_alb_target_group.alb_target.arn}"
  target_id        = "${aws_instance.web.id}"
  port             = "80"
}


resource "aws_alb_listener" "dojo" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target.arn}"
    type             = "forward"
  }
}
