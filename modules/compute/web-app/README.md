# Terraform module which creates EC2 and ALB.

These types of resources are created:

- EC2 Instance in private subnet
- ALB : Application Loadbalancer
- ALB : Target Group
- Instance Security Group
- ALB Security Group
- Instance Security Rule on port 22 from Bastion IP
- Instance Security Rule on port 80 from ALB Security Group

## Example usages:
```
module "webapp" {
    source="../../../../modules/compute/web-app"

    project = "myProject"
    env = "dev"

    ami = "ami-17c6736a"
    key_name = "ineat-default"

    vpc_id = "${data.aws_vpc.dojo.id}"
    subnet_id = "subnet-5a43f633"
    subnets = ["subnet-5a43f633", "subnet-2a34r565"]

    instance_type = "t2.nano"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | The project identifier used for name and tag for the created resources. | string | `myProject` | yes |
| env | A logical name that will be used as prefix and tag for the created resources. | string | `dev` | no |
| ami | The AMI Id to use with the ec2 instance . | string | `ami-xxxxx` | yes |
| key_name | The AWS key pair to use with the ec2 instance . | string | `default-key` | yes |
| vpc_id | The VPC Id to use for resources creation. | string | `vpc-1645f37f` | yes |
| subnet_id | The public subnets to use with the ec2 instance. | string | `subnet-5a43f633` | yes |
| subnets | The public subnets to use with ALB configuration. | list | `["subnet-5a43f633", "subnet-2a34r565"]` | yes |
| instance_type | The type of ec2 instance to create. | string | `t2.nano` | yes |
## Outputs

| Name | Description |
|------|-------------|
| web_private_ip | The private IP of the web instance. | string |
| web_public_ip | The public IP of the web instance. | string |
| alb_public_dns | The ALB public DNS name. | string |

