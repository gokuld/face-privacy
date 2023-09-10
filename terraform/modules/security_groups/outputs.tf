output "face_blur_model_service_security_group_id" {
  value = aws_security_group.face_blur_model_service_sg.id
}

output "face_blur_ui_security_group_id" {
  value = aws_security_group.face_blur_ui_sg.id
}
