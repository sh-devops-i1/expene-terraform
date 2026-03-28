module "frontend" {
  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "frontend"
  zone_id = var.zone_id

}
module "backend" {
  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "backend"
  zone_id = var.zone_id

}
module "mysql" {
  source        = "./modules/apps"
  env           = var.env
  instance_type = var.instance_type
  component     = "mysql"
  zone_id       = var.zone_id
}