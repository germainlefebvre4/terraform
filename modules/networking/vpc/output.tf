output "public_cidr" {
  value = "${aws_subnet.public.*.cidr_block}"
}

output "private_cidr" {
  value = "${aws_subnet.private.*.cidr_block}"
}

output "db_cidr" {
  value = "${aws_subnet.db.*.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "bastion_private_ip" {
  value = "${aws_instance.bastion.private_ip}"
}
