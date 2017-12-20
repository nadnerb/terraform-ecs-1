variable "aws_profile" {
  description = "The AWS profile to use (e.g can be found in /home/user/.aws/credentials)."
}

variable "region" {
  description = "The AWS region to create resources in."
  default = "ap-southeast-2"
}

variable "availability_zones" {
  description = "The availability zones"
  default = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
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
  type    = "map"
  default = {
    ap-southeast-2 = "ami-e3b75981"
  }
}

variable "instance_type" {
  default = "t2.small"
}

variable "vpc_id" {
  description = "The id of the vpc to deploy this ecs cluster."
}

variable "cidr_blocks" {
  description = "The cidr blocks for security groups."
}

variable "subnet_ids" {
  description = "The subnet ids (comma delimited) to deploy this ecs cluster."
}

variable "key_name" {
  description = "The aws ssh key name."
  default = "ecs"
}

variable "ec2_public_ips" {
  description = "Associate public ips with the instances. This will depend on the subnet placed in."
  default = true
}

variable "scaling_max_size" {
  description = "The maximum size for the autoscaling group."
  default = "3"
}

variable "scaling_min_size" {
  description = "The minimum size for the autoscaling group."
  default = "1"
}

variable "scaling_desired_capacity" {
  description = "The autoscaling desired capacity."
  default = "2"
}
