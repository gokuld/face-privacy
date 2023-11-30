#trivy:ignore:AVD-AWS-0104
#trivy:ignore:AVD-AWS-0107
resource "aws_security_group" "prometheus_sg" {
  name        = "prometheus-security-group"
  description = "Security group for the Prometheus EC2 instance."

  vpc_id = var.vpc_id

  ingress {
    description = "Allow incoming traffic on Prometheus default port 9090."
    from_port   = 9090
    to_port     = 9090
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
