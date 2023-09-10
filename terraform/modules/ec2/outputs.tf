output "prometheus_instance_public_ip" {
  value = aws_instance.prometheus_instance.public_ip
}

output "prometheus_instance_availability_zone" {
  value = aws_instance.prometheus_instance.availability_zone
}

output "rendered_cloud_init_template" {
  value = data.template_file.cloud_init.rendered
}
