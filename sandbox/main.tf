terraform {
  backend "s3" {
    bucket = "tf-ineat-sandbox"
    key    = "sandbox/terraform.tfstate"
    profile = "default"
    region = "eu-central-1"
  }
}

provider "aws" {
  region  = "${var.region}"
  profile = "default"
}

# EC2 instance AMI
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-2018.03*-ebs"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${module.vpc.vpc_id}"

  tags {
    Reach = "public"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${module.vpc.vpc_id}"

  tags {
    Reach = "private"
  }
}

data "aws_subnet_ids" "db" {
  vpc_id = "${module.vpc.vpc_id}"

  tags {
    Reach = "db"
  }
}

data "template_file" "init_script" {
  template = "${file("${path.module}/templates/init.d.script.sh")}"
}

data "template_file" "directory_user_data" {
  template = "${file("${path.module}/templates/init_dotnet.sh")}"

  vars {
    init_script = "${data.template_file.init_script.rendered}"
  }
}

module "vpc" {
  source = "../modules/networking/vpc"

  region  = "${var.region}"
  project = "${var.project}"
  env     = "${var.env}"
  cidr    = "${var.cidr}"

  instance_type = "${var.instance_type}"

  tags {
    Environment = "${var.env}"
    Project     = "${var.project}"
  }
}

