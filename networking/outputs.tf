output "vpc_id" {
  value = aws_vpc.gioserv_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.gioserv_rds_subnetgroup.*.name

}

output "vpc_security_group" {
  value = [aws_security_group.gioserv_sg["RDS"].id]
}
