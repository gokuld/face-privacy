#trivy:ignore:AVD-AWS-0104
#trivy:ignore:AVD-AWS-0107
resource "aws_security_group" "face_blur_ui_sg" {
  name        = "face-blur-ui-security-group"
  description = "Security group for the face blur UI ECS instances and load balancer."

  vpc_id = var.vpc_id

  ingress {
    description = "Allow incoming traffic on port 80."
    from_port   = 80
    to_port     = 80
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
