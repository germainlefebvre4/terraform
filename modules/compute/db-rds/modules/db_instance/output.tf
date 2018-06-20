# DB instance
output "this_db_instance_address" {
  description = "The address of the RDS instance"
  value       = "${element(concat(aws_db_instance.db.*.address, list("")), 0)}"
}

output "this_db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${element(concat(aws_db_instance.db.*.arn, list("")), 0)}"
}

output "this_db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = "${element(concat(aws_db_instance.db.*.availability_zone, list("")), 0)}"
}

output "this_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${element(concat(aws_db_instance.db.*.endpoint, list("")), 0)}"
}

output "this_db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${element(concat(aws_db_instance.db.*.hosted_zone_id, list("")), 0)}"
}

output "this_db_instance_id" {
  description = "The RDS instance ID"
  value       = "${element(concat(aws_db_instance.db.*.id, list("")), 0)}"
}

output "this_db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${element(concat(aws_db_instance.db.*.resource_id, list("")), 0)}"
}

output "this_db_instance_status" {
  description = "The RDS instance status"
  value       = "${element(concat(aws_db_instance.db.*.status, list("")), 0)}"
}

output "this_db_instance_name" {
  description = "The database name"
  value       = "${element(concat(aws_db_instance.db.*.name, list("")), 0)}"
}

output "this_db_instance_username" {
  description = "The master username for the database"
  value       = "${element(concat(aws_db_instance.db.*.username, list("")), 0)}"
}

output "this_db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = "${var.password}"
}

output "this_db_instance_port" {
  description = "The database port"
  value       = "${element(concat(aws_db_instance.db.*.port, list("")), 0)}"
}