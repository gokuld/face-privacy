data "template_file" "cloud_init" {
  template = templatefile("${path.module}/prometheus-cloud-init-script.yaml.tftpl", { output_filepath = "${path.module}/prometheus.yml" })
}

resource "aws_instance" "prometheus_instance" {
  subnet_id     = var.public_subnet_a_id
  ami           = "ami-0ded8326293d3201b" # TODO: make this a tf var
  instance_type = "t2.micro"              # TODO: make this a tf var
  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "prometheus-instance"
  }

  vpc_security_group_ids = [var.prometheus_security_group_id]

  user_data = data.template_file.cloud_init.rendered
}
