resource "aws_lb" "privfacy_lb" {
  name               = "privfacy-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.face_blur_model_service_security_group_id]

  enable_deletion_protection = false

  subnets = [var.public_subnet_a_id, var.public_subnet_b_id]
}
