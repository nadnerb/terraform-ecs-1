resource "aws_elb" "ecs-elb" {
  name = "${terraform.workspace}-${var.ecs_cluster_name}-elb"
  subnets = ["${split(",", var.subnet_ids)}"]

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  /* @todo - handle SSL */
  /*listener {
    instance_port = 5000
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }*/

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:3000/"
    interval            = 30
  }

  connection_draining = false

  tags {
    Name = "${terraform.workspace}-${var.ecs_cluster_name}-elb"
  }
}

