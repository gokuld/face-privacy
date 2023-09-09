resource "aws_security_group" "face_blur_model_service_sg" {
  name        = "face-blur-model-service-security-group"
  description = "Security group for the face blur model service ECS instances and load balancer."

  vpc_id = var.vpc_id

  ingress {
    description = "Allow face blur model service on port 3000."
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
