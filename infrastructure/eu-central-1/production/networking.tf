data "aws_vpc" "default_vpc" {
  default = true
  region  = "eu-central-1"
}

resource "aws_subnet" "dbt_core_subnet" {
  vpc_id            = data.aws_vpc.default_vpc.id
  cidr_block        = "172.31.32.0/20"
  availability_zone = "eu-central-1a"

  tags = {
    "Name" : "dbt_core_subnet_1_a"
  }
}

resource "aws_security_group" "dbt_core_sg" {
  name        = "dbt_core_sg"
  description = "Security group for dbt core vpc"
  vpc_id      = data.aws_vpc.default_vpc.id
}

resource "aws_vpc_security_group_egress_rule" "allows_tcp_egress" {
  security_group_id = aws_security_group.dbt_core_sg.id

  cidr_ipv4   = "10.0.0.0/8"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
