locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for SSH and HTTPS"
      ingress = {
        ssh = {
          from       = 22
          to         = 22
          protocol   = "tcp"
          cidr_block = ["0.0.0.0/0"]
        }
        http = {
          from       = 80
          to         = 80
          protocol   = "tcp"
          cidr_block = ["0.0.0.0/0"]
        }
      }
    }
    RDS = {
      name        = "RDS_sg"
      description = "Security group for RDS"
      ingress = {
        mysql = {
          from       = 3306
          to         = 3306
          protocol   = "tcp"
          cidr_block = [var.vpc_cidr]
        }
      }
    }
  }

}