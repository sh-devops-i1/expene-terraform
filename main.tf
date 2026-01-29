module "frontend" {
  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "frontend"
  zone_id = var.zone_id
  ssh_user = var.ssh_user
  ssh_password = var.ssh_password
}
module "backend" {
  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "backend"
  zone_id = var.zone_id
  ssh_user = var.ssh_user
  ssh_password = var.ssh_password
}
module "mysql" {
  source = "./modules/apps"
  env    = var.env
  instance_type = var.instance_type
  component = "mysql"
  zone_id = var.zone_id
  ssh_user = var.ssh_user
  ssh_password = var.ssh_password
}