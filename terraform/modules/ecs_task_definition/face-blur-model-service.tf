resource "aws_iam_role" "face_blur_model_service_execution_role" {
  name = "face_blur_model_service_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_execution_policy_attachment" {
  name       = "ecs-task-execution-policy-attachment"
  roles      = [aws_iam_role.face_blur_model_service_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "face_blur_model_service_task" {
  family                   = "face-blur-model-service-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.face_blur_model_service_execution_role.arn
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
