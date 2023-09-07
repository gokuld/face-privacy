resource "aws_ecs_service" "face_blur_model_service" {
  name            = "face-blur-model-service"
  task_definition = var.face_blur_model_service_task_arn
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.privfacy_cluster.id
  desired_count   = 1

  network_configuration {
    subnets          = [var.public_subnet_a_id, var.public_subnet_b_id]
    security_groups  = [var.face_blur_model_service_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.face_blur_model_service_lb_target_group_arn
    container_name   = var.face_blur_model_service_task_container_name
    container_port   = 3000
  }
}
