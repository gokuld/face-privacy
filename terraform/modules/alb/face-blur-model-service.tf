resource "aws_lb_target_group" "face_blur_model_service_tg" {
  name        = "model-service-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  # TODO: Add a health check config
  # health_check {
  #   path = "/api/health"
  # }
}

resource "aws_lb_listener" "face_blur_model_service_listener" {
  load_balancer_arn = aws_lb.privfacy_lb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.face_blur_model_service_tg.arn
  }
}
