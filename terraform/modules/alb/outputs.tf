output "privfacy_alb" {
  value = aws_lb.privfacy_lb
}

output "face_blur_model_service_lb_target_group_arn" {
  value = aws_lb_target_group.face_blur_model_service_tg.arn
}

output "face_blur_ui_lb_target_group_arn" {
  value = aws_lb_target_group.face_blur_ui_tg.arn
}

output "grafana_lb_target_group_arn" {
  value = aws_lb_target_group.grafana_tg.arn
}
