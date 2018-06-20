resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name ="${var.key_name}"

  subnet_id="${var.subnet_id}"
  vpc_security_group_ids=["${aws_security_group.web.id}"]

  user_data = "${var.user_data}"
  
  associate_public_ip_address = false
  
  tags = "${merge(var.tags, map("Name","web-${var.project}"))}"
}
