resource "aws_lb_target_group" "face_blur_model_service_tg" {
  name        = "model-service-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/healthz"
  }
}

resource "aws_lb_listener" "face_blur_model_service_listener" {
  load_balancer_arn = aws_lb.privfacy_lb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "403"
      message_body = "Access denied."
    }
  }
}

resource "aws_lb_listener_rule" "face_blur_model_service_rule" {
  listener_arn = aws_lb_listener.face_blur_model_service_listener.arn

  condition {
    host_header {
      values = ["api.privfacy.net"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.face_blur_model_service_tg.arn
  }
}
