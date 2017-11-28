provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  name_prefix          = "ecs-"
  image_id             = "${lookup(var.amis, var.region)}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  security_groups      = ["${aws_security_group.ecs.id}"]
  associate_public_ip_address = "${var.ec2_public_ips}"
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.ecs.name} > /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Autoscaling group.
 */
resource "aws_autoscaling_group" "ecs" {
  name                 = "ecs-asg"
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  min_size             = "${var.scaling_min_size}"
  max_size             = "${var.scaling_max_size}"
  desired_capacity     = "${var.scaling_desired_capacity}"
  vpc_zone_identifier  = ["${split(",", var.subnet_ids)}"]
  load_balancers       = ["${aws_elb.ecs-elb.id}"]
  health_check_type    = "EC2"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }
}

resource "aws_ecs_cluster" "ecs" {
  name = "${var.ecs_cluster_name}"
}

