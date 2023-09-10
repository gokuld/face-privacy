resource "aws_security_group" "grafana_sg" {
  name        = "grafana-security-group"
  description = "Security group for grafana ECS instances and load balancer."

  vpc_id = var.vpc_id

  ingress {
    description = "Allow incoming traffic on grafana default port 3000."
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic."
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
