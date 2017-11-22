variable "aws_access_key" {
  description = "The AWS access key."
}

variable "aws_secret_key" {
  description = "The AWS secret key."
}

variable "region" {
  description = "The AWS region to create resources in."
  default = "ap-southeast-2"
}

variable "availability_zones" {
  description = "The availability zones"
  /* default = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c" */
  default = "ap-southeast-2a,ap-southeast-2b"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default = "default"
}

variable "zone_name" {
  description = "The rout53 internal zone name"
}

/* ECS optimized AMIs per region */
variable "amis" {
  default = {
    ap-southeast-2 = "ami-e3b75981"
  }
}

variable "instance_type" {
  default = "t2.small"
}

variable "vpc_id" {
  /* FIXME */
  default = "vpc-a10660c4"
}

variable "subnet_ids" {
}

variable "key_name" {
  description = "The aws ssh key name."
  default = "ecs"
}

/* variable "key_file" { */
/*   description = "The ssh public key" */
/* } */
