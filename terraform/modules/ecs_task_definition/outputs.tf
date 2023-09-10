output "face_blur_model_service_task_arn" {
  value = aws_ecs_task_definition.face_blur_model_service_task.arn
}

output "face_blur_ui_task_arn" {
  value = aws_ecs_task_definition.face_blur_ui_task.arn
}
