# EC2 instance ressource
data "aws_ami" "ami" {
    most_recent = true
    filter {
        name = "owner-alias"
        values = ["amazon"]
    }
    filter {
        name = "name"
        values = ["amzn-ami-hvm-2017.03*-ebs"]
    }
}   

resource "aws_instance" "bastion" {
  ami           = "${data.aws_ami.ami.id}"
  instance_type = "${var.instance_type}"
  key_name ="ineat-default"

  subnet_id="${aws_subnet.public.0.id}"
  vpc_security_group_ids=["${aws_security_group.bastion.id}"]
  
  associate_public_ip_address = true
  
  tags = "${merge(var.tags, map("Name","bastion-${var.project}"))}"
}

resource "aws_security_group" "bastion" {
  name        = "${var.project}-bastion-sg"
  description = "bastion security group"

  vpc_id= "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = "${merge(var.tags, map("Name","sg-bastion-${var.project}" ))}"
}