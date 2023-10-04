terraform {
  cloud {
    organization = "gioserv"

    workspaces {
      name = "gio-dev"
    }
  }
}