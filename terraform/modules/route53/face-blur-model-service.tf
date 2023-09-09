resource "aws_route53_record" "face_blur_model_service_record" {
  zone_id = "/hostedzone/Z00531591T4DEGI8U1EUJ" # TODO: make this a tf var
  name    = "api"
  type    = "A"


  alias {
    name                   = var.lb.dns_name
    zone_id                = var.lb.zone_id
    evaluate_target_health = false
  }
}
