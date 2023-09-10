resource "aws_ecs_task_definition" "grafana_task" {
  family                   = "grafana-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "256"  # Adjust CPU units as needed  # TODO make this a tf var
  memory                   = "1024" # Adjust memory in MiB as needed  # TODO make this a tf var

  container_definitions = jsonencode([
    {
      name  = var.grafana_task_container_name
      image = "grafana/grafana-enterprise:latest"
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]

      network_configuration = {
        awsvpc_configuration = {
          subnets          = [var.public_subnet_a_id, var.public_subnet_b_id]
          security_groups  = [var.grafana_security_group_id]
          assign_public_ip = "ENABLED"
        }
      }
    }
  ])
}
