module "network" {
  source = "./modules/network"

  azs         = var.azs
  vpc_cidr    = var.vpc_cidr
  public_subnets = var.public_subnets
}

module "documentdb" {
  source = "./modules/DocumentDB"

  db_username            = var.db_username
  db_password            = var.db_password
  public_subnets         = module.network.public_subnets
  security_group_id      = module.network.security_group_id
}

module "app" {
  source = "./modules/app"
  region         = var.region
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
  ami_id         = var.ami_id
  key_name       = var.key_name
  db_username    = var.db_username
  db_password    = var.db_password
  db_host        = module.documentdb.docdb_endpoint
  db_name        = "InternBorobit"
  
}

module "dns" {
  source = "./modules/DNS"
  region = var.region
  domain_name = "cloudleaf.org"
  load_balancer_dns = module.app.load_balancer_dns
}