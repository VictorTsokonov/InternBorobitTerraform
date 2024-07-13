provider "aws" {
  region = var.region
}

data "aws_route53_zone" "selected" {
  name = "${var.domain_name}."
}

data "aws_lb" "app" {
  name = "app-lb"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = data.aws_lb.app.dns_name
    zone_id                = data.aws_lb.app.zone_id
    evaluate_target_health = true
  }
}

output "route53_zone_name" {
  value = data.aws_route53_zone.selected.name
}

output "route53_record_name" {
  value = aws_route53_record.www.fqdn
}

output "name_servers" {
  value = data.aws_route53_zone.selected.name_servers
}
