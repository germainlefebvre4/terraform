# Terraform module which creates VPC resources on AWS.

These types of resources are created:

- VPC
- [Public/Private/Db] Subnets
- Internet Gateway
- Nat Gawateway
- Route
- RouteTable
- Private Bastion

## Example usages:
```
module "vpc" {
    source="../../modules/networking/vpc"

    region = "eu-west-3"
    project = "myTerraformProject"
    env = "dev"
    cidr ="10.0.0.0/16"

    subnets = {
        public = "public"
        private = "private"
        db = "db"
    }

    availability_zones = {
        eu-west-3 = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    }

    instance_type = "t2.nano"
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zones |  | map | `<map>` | no |
| region | The Amazon region. | string | - | yes |
| cidr | The CDIR block used for the VPC. | string | `10.0.0.0/16` | no |
| project | The project identifier used for name and tag for the created resources. | string | `myProject` | yes |
| env | A logical name that will be used as prefix and tag for the created resources. | string | `dev` | no |

## Outputs

| Name | Description |
|------|-------------|
| public_cidr | The public subnet CIDR. | string |
| private_cidr | The private subnet CIDR. | string |
| db_cidr | The db subnet CIDR. | string |
| bastion_public_ip | The bastion public IP. | string |
| bastion_private_ip | The bastion private IP| string |