resource "aws_route53_record" "prometheus_record" {
  zone_id = "/hostedzone/Z00531591T4DEGI8U1EUJ" # TODO: make this a tf var
  name    = "prometheus"
  type    = "A"
  ttl     = 300

  records = [var.prometheus_instance_public_ip]
}
