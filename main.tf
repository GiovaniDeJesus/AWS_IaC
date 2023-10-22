module "networking" {
  source           = "./networking"
  vpc_cidr         = "10.16.0.0/16"
  private_sn_count = 3
  public_sn_count  = 2
  public_cidr      = [for i in range(1, 255, 2) : cidrsubnet("10.16.0.0/16", 8, i)]
  private_cidr     = [for i in range(2, 255, 2) : cidrsubnet("10.16.0.0/16", 8, i)]
  db_subnet_group = true
}

module "database" {
  source = "./database"
  db_storage = 10
  db_engine_version = "8.0.33"
  db_instance_class = "db.t2.micro"
  dbname = var.dbname
  dbuser = var.dbuser
  dbpassword = var.dbpassword
  db_identifier = "gioserv-db"
  skip_db_snapshot = true
  db_subnet_group_name = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.vpc_security_group
}