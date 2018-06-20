# Terraform scripts (for AWS)

Terraform scripts using module way. Only AWS Terraform scripts have been set for the moment.

**Table of Contents**
* [Requirements](#requirements)
   * [Install the binary](#install-the-binary)
   * [Run Terraform](#run-terraform)
* [Terraform scripts](#terraform-scripts)
   * [Make a sandbox VPC](#make-a-sandbox-vpc)


## Requirements

### Install the binary
You need to download the Terraform binary and add it in your environment path. You could find the latest binary on the [Terraform Download Page](https://www.terraform.io/downloads.html).

You can run these commands depending on the version of Terraform e.g. here `0.11.7` for `linux` in `amd64`
```sh
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip -d /usr/bin
```

### Run Terraform

After configurating the following Terraform scripts you can run it with Dry Run mode
**Dry Run mode**
```sh
terraform plan
```

And you can apply the needed modifications to stick to the Terraform configuration
**Apply modifications**
```sh
terraform apply
```


## Terraform scripts

### Make a sandbox VPC

Go in `sandbox/` directory.

Terraform scripts are set to save configuration on a S3 Bucket. Its configuration is standalone and independent from the rest of the scripts.

**S3 Backend**

Open the `main.tf` file and edit the`backend "s3"` part.
```sh
vi main.tf
```
Change the storage options : `bucket`, `key`, `profile`, `region`
```
terraform {
  backend "s3" {
    bucket = "tf-ineat-sandbox"
    key    = "sandbox/terraform.tfstate"
    profile = "default"
    region = "eu-central-1"
  }
}
```

**Variables**

The `vars.tf`contains global variables to help Terraform to apply the modifications depending on these variables.

Open the `vars.tf` file and edit the different options.
```
variable "region" {
  default = "eu-central-1"
}

variable "env" {
  default = "Sandbox"
}

variable "key_name" {
  default = "ineat-default"
}

variable "project" {
  default = "sandbox"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "cidr" {
  default = "192.168.0.0/16"
}
```






