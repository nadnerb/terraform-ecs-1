provider "aws" {
  profile    = "${var.aws_profile}"
  region     = "${var.region}"
}

/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  name_prefix                 = "${terraform.workspace}-${var.ecs_cluster_name}-lc-"
  image_id                    = "${lookup(var.amis, var.region)}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.ecs.id}"
  security_groups             = ["${aws_security_group.ecs.id}"]
  associate_public_ip_address = "${var.ec2_public_ips}"
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.ecs.name} > /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Autoscaling group.
 */
 // NEEDS A SCALING POLICY
resource "aws_autoscaling_group" "ecs" {
  name                 = "${terraform.workspace}-${var.ecs_cluster_name}-asg"
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  min_size             = "${var.scaling_min_size}"
  max_size             = "${var.scaling_max_size}"
  desired_capacity     = "${var.scaling_desired_capacity}"
  vpc_zone_identifier  = ["${split(",", var.subnet_ids)}"]
  health_check_type    = "EC2"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}-${var.ecs_cluster_name}-instance"
    propagate_at_launch = true
  }
}

resource "aws_ecs_cluster" "ecs" {
  name = "${terraform.workspace}-${var.ecs_cluster_name}"
}

