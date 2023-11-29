#trivy:ignore:AVD-AWS-0178
resource "aws_vpc" "privfacy_vpc" {
  cidr_block = "10.0.0.0/16"
}
