output "cluster_id" {
  value = "${aws_ecs_cluster.ecs.id}"
}

output "cluster_name" {
  value = "${aws_ecs_cluster.ecs.name}"
}

output "ecs_service_role_name" {
  value = "${aws_iam_role_policy.ecs_service_role_policy.name}"
}

output "ecs_instance_role_name" {
  value = "${aws_iam_role_policy.ecs_instance_role_policy.name}"
}
