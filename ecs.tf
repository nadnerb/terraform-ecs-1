provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

/* resource "aws_key_pair" "ecs" { */
/*   key_name   = "${var.key_name}" */
/*   public_key = "${file(var.key_file)}" */
/* } */

/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  name_prefix          = "ecs-"
  image_id             = "${lookup(var.amis, var.region)}"
  instance_type        = "${var.instance_type}"
  /* key_name             = "${aws_key_pair.ecs.key_name}" */
  key_name             = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  security_groups      = ["${aws_security_group.ecs.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
  /* FIXME */
  associate_public_ip_address = true
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
  /* availability_zones   = ["${split(",", var.availability_zones)}"] */
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  /* @todo - variables */
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  load_balancers       = ["${aws_elb.ecs-elb.id}"]
  health_check_type    = "EC2"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_cluster" "ecs" {
  name = "${var.ecs_cluster_name}"
}

