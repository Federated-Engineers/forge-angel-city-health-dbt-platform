resource "aws_vpc" "dbt_core" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" : "dbt_core_vpc"
  }
}

resource "aws_subnet" "dbt_core_subnet" {
  vpc_id            = aws_vpc.dbt_core.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "eu-central-1a"

  tags = {
    "Name" : "dbt_core_subnet_1_a"
  }
}

resource "aws_security_group" "dbt_core_sg" {
  name        = "dbt_core_sg"
  description = "Security group for dbt core vpc"
  vpc_id      = aws_vpc.dbt_core.id
}

resource "aws_internet_gateway" "dbt_core_igw" {
  vpc_id = aws_vpc.dbt_core.id

  tags = {
    Name = "dbt_core_igw"
  }
}

resource "aws_route" "route_to_internet" {
  route_table_id         = aws_vpc.dbt_core.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dbt_core_igw.id
}

resource "aws_vpc_security_group_egress_rule" "allows_tcp_egress" {
  security_group_id = aws_security_group.dbt_core_sg.id

  cidr_ipv4   = "10.0.0.0/8"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
