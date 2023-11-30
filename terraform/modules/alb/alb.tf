resource "aws_lb" "privfacy_lb" {
  name               = "privfacy-lb"
  load_balancer_type = "application"
  #trivy:ignore:AVD-AWS-0053
  internal                   = false
  enable_deletion_protection = false
  drop_invalid_header_fields = true

  security_groups = [var.face_blur_model_service_security_group_id, var.face_blur_ui_security_group_id, var.grafana_security_group_id]

  subnets = [var.public_subnet_a_id, var.public_subnet_b_id]
}
