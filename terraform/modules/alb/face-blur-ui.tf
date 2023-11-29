resource "aws_lb_target_group" "face_blur_ui_tg" {
  name        = "face-blur-ui-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/_stcore/health/"
  }
}

#trivy:ignore:AVD-AWS-0054
resource "aws_lb_listener" "face_blur_ui_listener" {
  load_balancer_arn = aws_lb.privfacy_lb.arn
  port              = 80
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

resource "aws_lb_listener_rule" "face_blur_ui_rule" {
  listener_arn = aws_lb_listener.face_blur_ui_listener.arn

  condition {
    host_header {
      values = ["www.privfacy.net"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.face_blur_ui_tg.arn
  }
}
