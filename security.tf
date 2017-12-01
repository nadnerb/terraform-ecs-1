/**
 * Provides internal access to container ports
 */
resource "aws_security_group" "ecs" {
  name = "${terraform.workspace}-${var.ecs_cluster_name}-ecs-sg"
  description = "Container Instance Allowed Ports"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 3310
    to_port   = 3310
    protocol  = "tcp"
    cidr_blocks = ["${var.cidr_blocks}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${terraform.workspace}-${var.ecs_cluster_name}-ecs-sg"
  }
}
