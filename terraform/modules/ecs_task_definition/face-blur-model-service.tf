resource "aws_ecs_task_definition" "face_blur_model_service_task" {
  family                   = "face-blur-model-service-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "512"  # Adjust CPU units as needed # TODO make this a tf var
  memory                   = "3072" # Adjust memory in MiB as needed # TODO make this a tf var

  container_definitions = jsonencode([
    {
      name  = var.face_blur_model_service_task_container_name
      image = "316254964329.dkr.ecr.ap-south-1.amazonaws.com/face-detector:latest" # TODO make this a tf var
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      network_configuration = {
        awsvpc_configuration = {
          subnets          = [var.public_subnet_a_id, var.public_subnet_b_id]
          security_groups  = [var.face_blur_model_service_security_group_id]
          assign_public_ip = "ENABLED"
        }
      }
    }
  ])
}
