resource "random_integer" "random" {
  min = 1
  max = 40
}

data "aws_availability_zones" "available" {
  

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
  #availability_zone = element(data.aws_availability_zones.available.names, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "gioserv_public${count.index + 1}"
  }
}

resource "aws_subnet" "gioserv_private_subnet" {
  count = var.private_sn_count
  vpc_id = aws_vpc.gioserv_vpc.id
  cidr_block = var.private_cidr[count.index]
  # availability_zone = element(data.aws_availability_zones.available.names, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "gioserv_private${count.index + 1}"
  }
}

resource "aws_route_table_association" "gioserv_public_association" {
  count = var.public_sn_count
  subnet_id = aws_subnet.gioserv_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.gioserv_public_rt.id
}

resource "aws_internet_gateway" "gioserv_internet_gateway" {
  vpc_id = aws_vpc.gioserv_vpc.id
  tags = {
    Name = "gioserv_igw"
  }
}

resource "aws_route_table" "gioserv_public_rt" {
  vpc_id = aws_vpc.gioserv_vpc.id

  tags = {
    Name = "gioserv_public"
  }
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.gioserv_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gioserv_internet_gateway.id
}

resource "aws_default_route_table" "gioserv_private_rt" {
  default_route_table_id = aws_vpc.gioserv_vpc.default_route_table_id
  tags = {
    Name = "gioserv_private"
  }
}