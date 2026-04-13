module "frontend" {
  depends_on = [module.backend]

  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "frontend"
  zone_id = var.zone_id
  vault_token   = var.vault_token
  vpc_id        = module.vpc.vpc_id
  subnet       = module.vpc.frontend_subnet
  lb_type      = "public"
  lb_needed    = true
  lb_subnet = module.vpc.public_subnet
  app_port     = 80

}
module "backend" {
  depends_on = [module.mysql]

  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "backend"
  zone_id = var.zone_id
  vault_token   = var.vault_token
  vpc_id        = module.vpc.vpc_id
  subnet       = module.vpc.backend_subnet
  lb_type      = "private"
  lb_subnet     = module.vpc.backend_subnet
  lb_needed    = true
  app_port      = 8080
}
module "mysql" {
  source        = "./modules/apps"
  env           = var.env
  instance_type = var.instance_type
  component     = "mysql"
  zone_id       = var.zone_id
  vault_token   = var.vault_token
  vpc_id        = module.vpc.vpc_id
  subnet       = module.vpc.db_subnet
}

module "vpc" {
  source = "./modules/vpc"
  env                    = var.env
  vpc_cidr_block         = var.vpc_cidr_block
  default_vpc_id         = var.default_vpc_id
  default_rt_ID          = var.default_rt_ID
  default_vpc_cidr_block = var.default_vpc_cidr_block
  frontend_subnets       = var.frontend_subnets
  backend_subnets        = var.backend_subnets
  db_subnets             = var.db_subnets
  Availability_zones     = var.Availability_zones
  public_subnet          = var.public_subnet


}