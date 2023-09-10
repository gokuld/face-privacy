resource "aws_ebs_volume" "prometheus_ebs" {
  availability_zone = var.prometheus_instance_availability_zone
  size              = 1 # 1 GB
  type              = "gp2"
  encrypted         = true
  tags = {
    Name = "PrometheusVolume"
  }
}
