resource "aws_lb" "privfacy_lb" {
  name                       = "privfacy-lb"
  load_balancer_type         = "application"
  internal                   = false
  enable_deletion_protection = true
  drop_invalid_header_fields = true

  security_groups = [var.face_blur_model_service_security_group_id]
  subnets         = [var.public_subnet_a_id, var.public_subnet_b_id]
}
