resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.privfacy_vpc.id
  cidr_block        = "10.0.1.0/24" # TODO: make this a tf var
  availability_zone = "ap-south-1a" # TODO: make this a tf var

  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.privfacy_vpc.id
  cidr_block        = "10.0.2.0/24" # TODO: make this a tf var
  availability_zone = "ap-south-1b" # TODO: make this a tf var

  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "privfacy_igw" {
  vpc_id = aws_vpc.privfacy_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.privfacy_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.privfacy_igw.id
  }
}

resource "aws_route_table_association" "subnet_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}
