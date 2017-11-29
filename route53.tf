data "aws_route53_zone" "internal" {
  name         = "${terraform.workspace}.${var.zone_name}"
  private_zone = true
}
