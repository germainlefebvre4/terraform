variable "region" { default = "eu-west-3"}
variable "project" { default="dojo" }
variable "env" { default = "dev"}
variable "cidr" { default = "10.0.0.0/16"}

variable "subnets" {
type = "map"
    default = {
        public = "public"
        private = "private"
        db = "db"
    }
}

variable "availability_zones" {  type = "map"  default = {    us-east-1      = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]    us-east-2      = ["us-east-2a", "eu-east-2b", "eu-east-2c"]    us-west-1      = ["us-west-1a", "us-west-1c"]    us-west-2      = ["us-west-2a", "us-west-2b", "us-west-2c"]    ca-central-1   = ["ca-central-1a", "ca-central-1b"]    eu-west-1      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]    eu-west-2      = ["eu-west-2a", "eu-west-2b"] eu-west-3 = ["eu-west-3a" , "eu-west-3b", "eu-west-3c"]    eu-central-1   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]    ap-south-1     = ["ap-south-1a", "ap-south-1b"]    sa-east-1      = ["sa-east-1a", "sa-east-1c"]    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]    ap-southeast-1 = ["ap-southeast-1a", "ap-southeast-1b"]    ap-southeast-2 = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]    ap-northeast-2 = ["ap-northeast-2a", "ap-northeast-2c"]  }}
variable "instance_type" { default = "t2.nano"}  # "t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "t2.xlarge", "t2.2xlarge", "m4.large", "m4.xlarge", "m4.2xlarge", "m4.4xlarge", "m4.10xlarge", "m4.16xlarge", "m3.medium", "m3.large", "m3.xlarge", "m3.2xlarge", "c4.large", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "c4.8xlarge", "c3.large", "c3.xlarge", "c3.2xlarge", "c3.4xlarge", "c3.8xlarge", "g2.2xlarge", "g2.8xlarge", "p2.xlarge", "p2.8xlarge", "p2.16xlarge", "r4.large", "r4.xlarge", "r4.2xlarge", "r4.4xlarge", "r4.8xlarge", "r4.16xlarge", "r3.large", "r3.xlarge", "r3.2xlarge", "r3.4xlarge", "r3.8xlarge", "x1.16xlarge", "x1.32xlarge", "d2.xlarge", "d2.2xlarge", "d2.4xlarge", "d2.8xlarge", "i2.xlarge", "i2.2xlarge", "i2.4xlarge", "i2.8xlarge", "i3.large", "i3.xlarge", "i3.2xlarge", "i3.4xlarge", "i3.8xlarge", "i3.16xlarge"
variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the resource"
  default     = {}
}