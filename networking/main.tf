resource "random_integer" "random" {
  min = 1
  max = 40
}

resource "aws_vpc" "gioserv_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "gioserv_vpc-${random_integer.random.id}" 
  }
}

resource "aws_subnet" "gioserv_public_subnet" {
  count = var.public_sn_count
  vpc_id = aws_vpc.gioserv_vpc.id
  cidr_block = var.public_cidr[count.index]
  map_public_ip_on_launch = true 
  availability_zone = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]

  tags = {
    Name = "gioserv_public${count.index + 1}"
  }
}

resource "aws_subnet" "gioserv_private_subnet" {
  count = var.private_sn_count
  vpc_id = aws_vpc.gioserv_vpc.id
  cidr_block = var.private_cidr[count.index]
  availability_zone = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]

  tags = {
    Name = "gioserv_private${count.index + 1}"
  }
}

