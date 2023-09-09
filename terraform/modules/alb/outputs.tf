output "face_blur_model_service_lb_target_group_arn" {
  value = aws_lb_target_group.face_blur_model_service_tg.arn
}

output "privfacy_alb" {
  value = aws_lb.privfacy_lb
}
