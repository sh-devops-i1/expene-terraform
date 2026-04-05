# module "frontend" {
#   depends_on = [module.backend]
#
#   source = "./modules/apps"
#   env    = var.env
#   instance_type = var.instance_type
#   component = "frontend"
#   zone_id = var.zone_id
#   vault_token   = var.vault_token
#
# }
# module "backend" {
#   depends_on = [module.mysql]
#
#   source = "./modules/apps"
#   env    = var.env
#   instance_type = var.instance_type
#   component = "backend"
#   zone_id = var.zone_id
#   vault_token   = var.vault_token
#
# }
# module "mysql" {
#   source        = "./modules/apps"
#   env           = var.env
#   instance_type = var.instance_type
#   component     = "mysql"
#   zone_id       = var.zone_id
#   vault_token   = var.vault_token
# }

module "vpc" {
  source = "./modules/vpc"
  env                    = var.env
  vpc_cidr_block         = var.vpc_cidr_block
  subnet_cidr            = var.subnet_cidr
  default_vpc_id         = var.default_vpc_id
  default_rt_ID          = var.default_rt_ID
  default_vpc_cidr_block = var.default_vpc_cidr_block
  frontend_subnets       = var.frontend_subnets
  backend_subnets        = var.backend_subnets
  db_subnets             = var.db_subnets
  Availability_zones     = var.Availability_zones


}